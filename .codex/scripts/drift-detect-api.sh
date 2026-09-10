#!/usr/bin/env bash
# drift-detect-api.sh — Detects drift between api-spec.md and actual route handlers
#
# Usage: ./scripts/drift-detect-api.sh [--spec <file>] [--routes-dir <dir>]
# Exit 0 = no drift. Exit 1 = drift detected.
#
# Looks for:
#   - Endpoints defined in api-spec.md but missing from route handler files
#   - Simple heuristic: METHOD /path patterns

set -euo pipefail

SPEC_FILE="${SPEC_FILE:-docs/api-spec.md}"
ROUTES_DIR="${ROUTES_DIR:-src/}"
DRIFT=()

# Allow overrides from flags
while [[ $# -gt 0 ]]; do
  case "$1" in
    --spec)       SPEC_FILE="$2"; shift 2 ;;
    --routes-dir) ROUTES_DIR="$2"; shift 2 ;;
    *) shift ;;
  esac
done

echo "── API Drift Detection ───────────────────────────────"
echo "   Spec:   $SPEC_FILE"
echo "   Routes: $ROUTES_DIR"

[ -f "$SPEC_FILE" ] || { echo "  ⚠️  Spec file not found: $SPEC_FILE (skipping)"; exit 0; }

# Extract endpoint signatures from spec: lines like `GET /customers` or `POST /users/{id}`
SPEC_ENDPOINTS=$(grep -oE '(GET|POST|PUT|PATCH|DELETE)[[:space:]]+/[a-zA-Z0-9/_{}:-]+' "$SPEC_FILE" | sort -u)

if [ -z "$SPEC_ENDPOINTS" ]; then
  echo "  ⚠️  No endpoints found in spec (format: METHOD /path) — skipping"
  exit 0
fi

ENDPOINT_COUNT=$(echo "$SPEC_ENDPOINTS" | wc -l | tr -d ' ')
echo "  Found $ENDPOINT_COUNT endpoints in spec"

while IFS= read -r endpoint; do
  METHOD=$(echo "$endpoint" | awk '{print $1}' | tr '[:upper:]' '[:lower:]')
  PATH_PART=$(echo "$endpoint" | awk '{print $2}')
  # Simplify path: /customers/{id} → customers
  ROUTE_SLUG=$(echo "$PATH_PART" | tr '/' '\n' | grep -v '^$' | grep -v '{' | head -1)

  if [ -z "$ROUTE_SLUG" ]; then
    continue
  fi

  # Search for route handler pattern: router.get/post/put/patch/delete with the slug
  FOUND=$(grep -rl --include="*.ts" --include="*.tsx" --include="*.js" \
    -e "router\.$METHOD" -e "app\.$METHOD" -e "\"$METHOD\"" -e "'$METHOD'" \
    "$ROUTES_DIR" 2>/dev/null | \
    xargs grep -l "$ROUTE_SLUG" 2>/dev/null || true)

  if [ -z "$FOUND" ]; then
    DRIFT+=("MISSING HANDLER: $endpoint (slug: $ROUTE_SLUG)")
  fi
done <<< "$SPEC_ENDPOINTS"

if [ ${#DRIFT[@]} -eq 0 ]; then
  echo "  ✅ No API drift detected"
  exit 0
else
  echo "  ❌ API drift detected:"
  for d in "${DRIFT[@]}"; do
    echo "    - $d"
  done
  echo ""
  echo "  Fix: implement handlers or update api-spec.md to match current routes"
  exit 1
fi
