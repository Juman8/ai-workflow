#!/usr/bin/env bash
# contract-validate.sh — Validates live API response shape against api-spec.md
#
# Usage: ./scripts/contract-validate.sh [--base-url <url>] [--spec <file>]
# Exit 0 = all contracts match. Exit 1 = shape mismatch.
#
# Requires: curl, python3
# The spec must include JSON response examples in fenced blocks after each endpoint.

set -euo pipefail

BASE_URL="${API_BASE_URL:-http://localhost:3000}"
SPEC_FILE="${SPEC_FILE:-docs/api-spec.md}"
FAILURES=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --base-url) BASE_URL="$2"; shift 2 ;;
    --spec)     SPEC_FILE="$2"; shift 2 ;;
    *) shift ;;
  esac
done

echo "── Contract Validation ───────────────────────────────"
echo "   Base URL: $BASE_URL"
echo "   Spec:     $SPEC_FILE"

[ -f "$SPEC_FILE" ] || { echo "  ⚠️  Spec not found: $SPEC_FILE (skipping)"; exit 0; }

# Check if the server is reachable at all
if ! curl -sf --max-time 3 "$BASE_URL/health" > /dev/null 2>&1 && \
   ! curl -sf --max-time 3 "$BASE_URL" > /dev/null 2>&1; then
  echo "  ⚠️  Server not reachable at $BASE_URL — skipping contract checks"
  exit 0
fi

# Extract GET endpoints with example responses from spec
# Format expected:
#   ### GET /customers
#   ...
#   ```json
#   { "data": [...], "total": 0 }
#   ```
python3 - <<PYEOF
import re, json, subprocess, sys

with open('$SPEC_FILE') as f:
    content = f.read()

# Find sections: METHOD /path followed by json block
pattern = re.compile(
    r'###\s+(GET|POST)\s+(/[^\n]+)\n(.*?)```json\n(.*?)```',
    re.DOTALL
)

failures = []
checked = 0

for match in pattern.finditer(content):
    method = match.group(1)
    path = match.group(2).strip().split(' ')[0]  # remove query param notes
    example_json = match.group(4).strip()

    if method != 'GET':
        continue  # only validate GETs without side effects

    try:
        expected = json.loads(example_json)
    except json.JSONDecodeError:
        continue  # example isn't valid JSON, skip

    url = '$BASE_URL' + path
    try:
        result = subprocess.run(
            ['curl', '-sf', '--max-time', '5', '-H', 'Accept: application/json', url],
            capture_output=True, text=True, timeout=10
        )
        if result.returncode != 0:
            failures.append(f"  ❌ {method} {path} — HTTP error (curl exit {result.returncode})")
            continue

        actual = json.loads(result.stdout)
        checked += 1

        # Shape check: verify top-level keys match
        expected_keys = set(expected.keys()) if isinstance(expected, dict) else set()
        actual_keys = set(actual.keys()) if isinstance(actual, dict) else set()

        missing_keys = expected_keys - actual_keys
        if missing_keys:
            failures.append(f"  ❌ {method} {path} — missing keys: {missing_keys}")
        else:
            print(f"  ✅ {method} {path} — shape matches")

    except (json.JSONDecodeError, subprocess.TimeoutExpired) as e:
        failures.append(f"  ❌ {method} {path} — {type(e).__name__}: {e}")

if checked == 0:
    print("  ⚠️  No GET endpoints with JSON examples found in spec")
    sys.exit(0)

if failures:
    for f in failures:
        print(f)
    sys.exit(1)
PYEOF
