#!/usr/bin/env bash
# validate-prp.sh — Validates PRP YAML front-matter against prp-schema.json
#
# Usage: ./scripts/validate-prp.sh <prp-file>
# Exit 0 = valid. Exit 1 = invalid.
#
# Requirements: yq, python3 (or ajv-cli)

set -euo pipefail

PRP_FILE="${1:-}"
SCHEMA="$(dirname "$0")/../tpl/prp-schema.json"
ERRORS=()

[ -z "$PRP_FILE" ] && { echo "Usage: validate-prp.sh <prp-file>"; exit 1; }
[ -f "$PRP_FILE" ] || { echo "File not found: $PRP_FILE"; exit 1; }
[ -f "$SCHEMA"   ] || { echo "Schema not found: $SCHEMA"; exit 1; }

echo "Validating: $PRP_FILE"

# Extract YAML front-matter (between --- delimiters)
FRONT_MATTER=$(awk '/^---/{p++; if(p==2) exit; next} p==1' "$PRP_FILE")

if [ -z "$FRONT_MATTER" ]; then
  echo "  ❌ No YAML front-matter found (missing --- block)"
  exit 1
fi

# Convert to JSON and validate with python jsonschema
TEMP_JSON=$(mktemp /tmp/prp-XXXX.json)
echo "$FRONT_MATTER" | python3 -c "
import sys, json, yaml
data = yaml.safe_load(sys.stdin.read())
print(json.dumps(data, ensure_ascii=False))
" > "$TEMP_JSON" 2>/dev/null || { echo "  ❌ YAML parse error in front-matter"; exit 1; }

# Validate required fields manually (works without ajv-cli)
python3 - <<PYEOF
import json, sys

with open('$TEMP_JSON') as f:
    data = json.load(f)

with open('$SCHEMA') as f:
    schema = json.load(f)

errors = []
required = schema.get('required', [])
for field in required:
    if field not in data:
        errors.append(f"Missing required field: '{field}'")

# Validate task_id pattern
import re
if 'task_id' in data:
    if not re.match(r'^[A-Z]+-[0-9]+$', data['task_id']):
        errors.append(f"task_id must match pattern [A-Z]+-[0-9]+, got: {data['task_id']}")

# Validate acceptance_criteria
if 'acceptance_criteria' in data:
    for i, ac in enumerate(data['acceptance_criteria']):
        for field in ['id', 'description', 'type', 'test_hint']:
            if field not in ac:
                errors.append(f"acceptance_criteria[{i}] missing '{field}'")
        if 'type' in ac:
            valid_types = ['functional', 'integration', 'visual', 'performance', 'security']
            if ac['type'] not in valid_types:
                errors.append(f"AC '{ac.get('id',i)}' type must be one of {valid_types}")
        if 'test_hint' in ac and len(ac['test_hint']) < 10:
            errors.append(f"AC '{ac.get('id',i)}' test_hint too short (min 10 chars)")

# Validate quality_gate
if 'quality_gate' in data:
    qg = data['quality_gate']
    if 'min_score' in qg and not (50 <= qg['min_score'] <= 100):
        errors.append(f"quality_gate.min_score must be 50–100, got: {qg['min_score']}")
    if 'max_iterations' in qg and not (1 <= qg['max_iterations'] <= 5):
        errors.append(f"quality_gate.max_iterations must be 1–5, got: {qg['max_iterations']}")

if errors:
    for e in errors:
        print(f"  ❌ {e}")
    sys.exit(1)
else:
    print(f"  ✅ PRP schema valid ({len(data.get('acceptance_criteria',[]))} ACs, threshold {data.get('quality_gate',{}).get('min_score','?')})")
PYEOF

rm -f "$TEMP_JSON"
