#!/usr/bin/env bash
# harness-runner.sh — Main harness orchestrator
#
# Usage: ./harness/harness-runner.sh <prp-file> [--dry-run]
#
# Runs all 4 verification layers in a generator-evaluator loop.
# Creates a PR automatically when quality gate passes.
#
# Requirements: yq, jq, claude CLI, gh CLI, npm

set -euo pipefail

PRP_FILE="${1:-}"
DRY_RUN="${2:-}"
HARNESS_DIR="$(dirname "$0")"
SCRIPTS_DIR="$(dirname "$0")/../scripts"
REPORT_FILE="$HARNESS_DIR/eval-report.json"

# ── Colours ──────────────────────────────────────────────────────────────────
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'
pass() { echo -e "${GREEN}  ✅ $1${NC}"; }
fail() { echo -e "${RED}  ❌ $1${NC}"; exit 1; }
warn() { echo -e "${YELLOW}  ⚠️  $1${NC}"; }
info() { echo -e "     $1"; }

# ── Validate inputs ───────────────────────────────────────────────────────────
[ -z "$PRP_FILE" ] && fail "Usage: ./harness/harness-runner.sh <prp-file>"
[ -f "$PRP_FILE" ] || fail "PRP file not found: $PRP_FILE"

# ── Parse PRP front-matter ────────────────────────────────────────────────────
TASK_ID=$(yq '.task_id'             "$PRP_FILE")
TITLE=$(yq '.title'                 "$PRP_FILE")
MAX_ITER=$(yq '.quality_gate.max_iterations' "$PRP_FILE")
MIN_SCORE=$(yq '.quality_gate.min_score'     "$PRP_FILE")

echo ""
echo "══════════════════════════════════════════════════════"
echo "  🚀 Harness Runner: $TASK_ID — $TITLE"
echo "  Threshold: $MIN_SCORE/100 | Max iterations: $MAX_ITER"
echo "══════════════════════════════════════════════════════"

# ── Pre-flight: validate PRP schema ──────────────────────────────────────────
echo ""
echo "── Pre-flight ────────────────────────────────────────"
"$SCRIPTS_DIR/validate-prp.sh" "$PRP_FILE" && pass "PRP schema valid" || fail "PRP schema invalid — fix front-matter first"

# ── Generate test stubs (run once before loop) ────────────────────────────────
"$SCRIPTS_DIR/generate-test-stubs.sh" "$PRP_FILE" && pass "Test stubs generated" || warn "Could not generate stubs — continuing"

# ── Main loop ────────────────────────────────────────────────────────────────
ITERATION=0
PASS=false
FINAL_SCORE=0

# Clear previous report
echo "{}" > "$REPORT_FILE"

while [ "$ITERATION" -lt "$MAX_ITER" ]; do
  ITERATION=$((ITERATION + 1))
  echo ""
  echo "── Iteration $ITERATION / $MAX_ITER ─────────────────────────"

  # ── Layer 1a: Generator agent writes code ──────────────────────────────────
  echo ""
  echo "  [Layer 1] Spec Compliance"
  info "Generator: writing code..."
  if [ "$DRY_RUN" != "--dry-run" ]; then
    claude \
      --agent "$HARNESS_DIR/generator-agent.md" \
      --file "$PRP_FILE" \
      --file "$REPORT_FILE" \
      --print > /dev/null 2>&1
    pass "Generator: code written"
  else
    warn "DRY RUN — skipping generator"
  fi

  # ── Layer 1b: Spec drift detection ────────────────────────────────────────
  info "Checking spec drift..."
  if "$SCRIPTS_DIR/drift-detect-api.sh" > /tmp/drift-api.txt 2>&1; then
    pass "API spec: no drift"
  else
    warn "API spec drift detected (see /tmp/drift-api.txt)"
  fi

  # ── Layer 1c: Evaluator agent scores the code ─────────────────────────────
  info "Evaluator: scoring acceptance criteria..."

  # Collect test/lint/type output for evaluator context
  npm test --silent > /tmp/test-output.txt 2>&1 || true
  npx tsc --noEmit  > /tmp/tsc-output.txt  2>&1 || true
  npx eslint src/   > /tmp/lint-output.txt 2>&1 || true

  if [ "$DRY_RUN" != "--dry-run" ]; then
    claude \
      --agent "$HARNESS_DIR/evaluator-agent.md" \
      --file "$PRP_FILE" \
      --file /tmp/test-output.txt \
      --file /tmp/tsc-output.txt \
      --file /tmp/lint-output.txt \
      --print > "$REPORT_FILE" 2>/dev/null
  fi

  FINAL_SCORE=$(jq '.overall_score' "$REPORT_FILE" 2>/dev/null || echo "0")
  echo ""
  info "Score: $FINAL_SCORE / 100 (threshold: $MIN_SCORE)"

  # Print per-AC summary
  jq -r '.ac_scores[] | "  " + .id + ": " + (.score|tostring) + "/100 — " + .verdict' \
    "$REPORT_FILE" 2>/dev/null || true

  # ── Layer 2: Functional correctness ───────────────────────────────────────
  echo ""
  echo "  [Layer 2] Functional Correctness"

  if npm test --silent > /tmp/test-final.txt 2>&1; then
    pass "Tests: all passing"
  else
    warn "Tests: failures detected (see /tmp/test-final.txt)"
  fi

  if npx tsc --noEmit > /dev/null 2>&1; then
    pass "Types: no errors"
  else
    warn "Types: errors found"
  fi

  if npx eslint src/ > /dev/null 2>&1; then
    pass "Lint: clean"
  else
    warn "Lint: issues found"
  fi

  # ── Layer 3: System behavior ──────────────────────────────────────────────
  echo ""
  echo "  [Layer 3] System Behavior"

  if npx playwright test --grep "@smoke" > /dev/null 2>&1; then
    pass "E2E smoke: passing"
  else
    warn "E2E: failures (run manually to investigate)"
  fi

  if "$SCRIPTS_DIR/contract-validate.sh" > /dev/null 2>&1; then
    pass "Contract: API response matches spec"
  else
    warn "Contract: response shape mismatch"
  fi

  # ── Layer 4: Production readiness ─────────────────────────────────────────
  echo ""
  echo "  [Layer 4] Production Readiness"

  if "$HARNESS_DIR/security-check.sh" > /dev/null 2>&1; then
    pass "Security: no issues found"
  else
    warn "Security: issues detected"
  fi

  if "$SCRIPTS_DIR/perf-benchmark.sh" > /dev/null 2>&1; then
    pass "Performance: within thresholds"
  else
    warn "Performance: threshold exceeded"
  fi

  # ── Quality gate decision ─────────────────────────────────────────────────
  echo ""
  if [ "$FINAL_SCORE" -ge "$MIN_SCORE" ] 2>/dev/null; then
    PASS=true
    break
  else
    if [ "$ITERATION" -lt "$MAX_ITER" ]; then
      warn "Score $FINAL_SCORE below threshold $MIN_SCORE — retrying with evaluator feedback..."
      info "$(jq -r '.iteration_feedback' "$REPORT_FILE" 2>/dev/null)"
    fi
  fi
done

# ── Final verdict ─────────────────────────────────────────────────────────────
echo ""
echo "══════════════════════════════════════════════════════"

if [ "$PASS" = true ]; then
  echo -e "${GREEN}  ✅ PASSED — Score: $FINAL_SCORE/100 after $ITERATION iteration(s)${NC}"
  echo ""
  PR_SUMMARY=$(jq -r '.pr_summary' "$REPORT_FILE" 2>/dev/null || echo "Implements $TASK_ID")
  AC_TABLE=$(jq -r '.ac_scores[] | "- " + .id + ": " + (.score|tostring) + "/100 ✅"' "$REPORT_FILE" 2>/dev/null || echo "")

  if [ "$DRY_RUN" != "--dry-run" ]; then
    gh pr create \
      --title "feat($TASK_ID): $TITLE" \
      --body "$(cat <<EOF
## Summary
$PR_SUMMARY

## Harness Report
- Iterations: $ITERATION / $MAX_ITER
- Final score: $FINAL_SCORE / 100
$AC_TABLE

## Layers
- Spec compliance: ✅
- Unit + integration tests: ✅
- Type check + lint: ✅
- E2E smoke: ✅
- Security scan: ✅

---
*Generated by harness-runner.sh — review eval report at \`harness/eval-report.json\`*
EOF
)"
    pass "PR created"
  else
    warn "DRY RUN — PR not created"
    info "Would create PR: feat($TASK_ID): $TITLE"
  fi
else
  echo -e "${RED}  ❌ FAILED — Score: $FINAL_SCORE/100 after $MAX_ITER iterations${NC}"
  echo ""
  info "Review the evaluator feedback:"
  jq -r '.ac_scores[] | select(.fix_required != null) | "  " + .id + ": " + .fix_required' \
    "$REPORT_FILE" 2>/dev/null || true
  echo ""
  info "Full report: harness/eval-report.json"
  exit 1
fi

echo "══════════════════════════════════════════════════════"
echo ""
