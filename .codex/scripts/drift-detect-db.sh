#!/usr/bin/env bash
# drift-detect-db.sh — Detects drift between db-design.md and migration files
#
# Usage: ./scripts/drift-detect-db.sh [--spec <file>] [--migrations-dir <dir>]
# Exit 0 = no drift. Exit 1 = drift detected.
#
# Looks for table names defined in db-design.md that are absent from migrations.

set -euo pipefail

SPEC_FILE="${DB_SPEC_FILE:-docs/db-design.md}"
MIGRATIONS_DIR="${MIGRATIONS_DIR:-migrations/}"
DRIFT=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --spec)           SPEC_FILE="$2"; shift 2 ;;
    --migrations-dir) MIGRATIONS_DIR="$2"; shift 2 ;;
    *) shift ;;
  esac
done

echo "── DB Drift Detection ────────────────────────────────"
echo "   Spec:       $SPEC_FILE"
echo "   Migrations: $MIGRATIONS_DIR"

[ -f "$SPEC_FILE" ] || { echo "  ⚠️  DB spec not found: $SPEC_FILE (skipping)"; exit 0; }
[ -d "$MIGRATIONS_DIR" ] || { echo "  ⚠️  Migrations dir not found: $MIGRATIONS_DIR (skipping)"; exit 0; }

# Extract table names: lines like `## Table: customers` or `CREATE TABLE customers`
SPEC_TABLES=$(grep -oE '(Table:|CREATE TABLE)[[:space:]]+[a-z_]+' "$SPEC_FILE" | \
  grep -oE '[a-z_]+$' | sort -u)

if [ -z "$SPEC_TABLES" ]; then
  echo "  ⚠️  No table names found in spec — skipping"
  exit 0
fi

TABLE_COUNT=$(echo "$SPEC_TABLES" | wc -l | tr -d ' ')
echo "  Found $TABLE_COUNT tables in spec"

while IFS= read -r table; do
  [ -z "$table" ] && continue
  FOUND=$(grep -rl --include="*.sql" --include="*.ts" --include="*.js" \
    "\"$table\"\|'$table'\|$table" "$MIGRATIONS_DIR" 2>/dev/null || true)

  if [ -z "$FOUND" ]; then
    DRIFT+=("MISSING MIGRATION: table '$table' not found in $MIGRATIONS_DIR")
  fi
done <<< "$SPEC_TABLES"

if [ ${#DRIFT[@]} -eq 0 ]; then
  echo "  ✅ No DB drift detected"
  exit 0
else
  echo "  ❌ DB drift detected:"
  for d in "${DRIFT[@]}"; do
    echo "    - $d"
  done
  echo ""
  echo "  Fix: add migrations for new tables or update db-design.md"
  exit 1
fi
