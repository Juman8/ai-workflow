#!/usr/bin/env bash
# generate-test-stubs.sh — Creates test skeleton files from PRP acceptance criteria
#
# Usage: ./scripts/generate-test-stubs.sh <prp-file>
# Reads PRP YAML front-matter and emits __tests__/<ComponentName>.test.tsx stubs.
# Does NOT overwrite existing test files — only creates missing ones.

set -euo pipefail

PRP_FILE="${1:-}"
[ -z "$PRP_FILE" ] && { echo "Usage: generate-test-stubs.sh <prp-file>"; exit 1; }
[ -f "$PRP_FILE" ] || { echo "File not found: $PRP_FILE"; exit 1; }

FRONT_MATTER=$(awk '/^---/{p++; if(p==2) exit; next} p==1' "$PRP_FILE")
[ -z "$FRONT_MATTER" ] && { echo "  ❌ No YAML front-matter found"; exit 1; }

TASK_ID=$(echo "$FRONT_MATTER" | python3 -c "import sys,yaml; d=yaml.safe_load(sys.stdin); print(d.get('task_id','UNKNOWN'))")
TARGET_FILES=$(echo "$FRONT_MATTER" | python3 -c "
import sys, yaml
d = yaml.safe_load(sys.stdin)
for f in d.get('target_files', []):
    print(f)
")

echo "Generating test stubs for: $TASK_ID"

python3 - <<PYEOF
import sys, yaml, os, re

front_matter = """$FRONT_MATTER"""
data = yaml.safe_load(front_matter)

task_id = data.get('task_id', 'UNKNOWN')
target_files = data.get('target_files', [])
acs = data.get('acceptance_criteria', [])

# Group ACs by file stem for routing stubs to the right test file
# Primary component = first .tsx or .ts target file
primary_file = next((f for f in target_files if f.endswith('.tsx') or f.endswith('.ts')), None)
if not primary_file:
    print("  ⚠️  No .tsx/.ts target files found — skipping stub generation")
    sys.exit(0)

base_name = os.path.basename(primary_file)
stem = re.sub(r'\.(tsx|ts)$', '', base_name)
component_name = stem

# Determine test file location: mirror src path under __tests__
src_rel = primary_file.replace('src/', '', 1) if primary_file.startswith('src/') else primary_file
src_stem = re.sub(r'\.(tsx|ts)$', '', src_rel)
test_file = f"__tests__/{src_stem}.test.tsx"

# Create parent directory
os.makedirs(os.path.dirname(test_file) if os.path.dirname(test_file) else '.', exist_ok=True)

if os.path.exists(test_file):
    print(f"  ⏭  {test_file} already exists — skipping")
    sys.exit(0)

# Build import path relative to __tests__ dir
depth = test_file.count('/') - 1
rel_prefix = '../' * depth if depth > 0 else './'
import_path = rel_prefix + primary_file.replace('src/', '').replace('.tsx', '').replace('.ts', '')

lines = []
lines.append(f"// Auto-generated stub for {task_id} — fill in real assertions")
lines.append(f"// Source: {primary_file}")
lines.append("")
lines.append("import React from 'react';")
lines.append("import { render, screen, waitFor } from '@testing-library/react';")
lines.append("import userEvent from '@testing-library/user-event';")
lines.append(f"import {{ {component_name} }} from '{import_path}';")
lines.append("")

# Mocks block
lines.append("// Mock dependencies")
lines.append("jest.mock('../src/stores/useCustomerStore');")
lines.append("")

# Describe block
lines.append(f"describe('{component_name}', () => {{")
lines.append("  beforeEach(() => {")
lines.append("    jest.clearAllMocks();")
lines.append("  });")
lines.append("")

for ac in acs:
    ac_id = ac.get('id', '?')
    description = ac.get('description', 'TODO')
    test_hint = ac.get('test_hint', 'TODO: add assertion')
    ac_type = ac.get('type', 'functional')

    lines.append(f"  // {ac_id}: {description}")
    lines.append(f"  it('{description}', async () => {{")
    lines.append(f"    // hint: {test_hint}")
    lines.append(f"    // TODO: implement this {ac_type} test")
    lines.append(f"    render(<{component_name} />);")
    lines.append(f"    // expect(...).toBe(...);")
    lines.append("    throw new Error('Test not implemented — RED phase');")
    lines.append("  });")
    lines.append("")

lines.append("});")

with open(test_file, 'w') as f:
    f.write('\n'.join(lines) + '\n')

print(f"  ✅ Created {test_file} ({len(acs)} AC stubs)")
PYEOF
