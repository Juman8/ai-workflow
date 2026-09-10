#!/usr/bin/env bash
# security-check.sh — Layer 4 security gate
#
# Usage: ./harness/security-check.sh [files...]
# Scans target files for common security issues.
# Exit 0 = clean. Exit 1 = issues found.

set -euo pipefail

FILES="${*:-src/}"
ISSUES=()

check() {
  local label="$1"; local pattern="$2"; local target="$3"
  if grep -rn --include="*.ts" --include="*.tsx" "$pattern" "$target" > /dev/null 2>&1; then
    ISSUES+=("$label: $(grep -rn --include="*.ts" --include="*.tsx" "$pattern" "$target" | head -3)")
  fi
}

echo "── Security Check ────────────────────────────────────"

# Hardcoded secrets
check "HARDCODED_SECRET"   "api[_-]?key\s*=\s*['\"][a-zA-Z0-9]"         "$FILES"
check "HARDCODED_SECRET"   "password\s*=\s*['\"][^'\"]\{4,\}"            "$FILES"
check "HARDCODED_TOKEN"    "Bearer [a-zA-Z0-9\-_]{20,}"                  "$FILES"

# Injection risks
check "SQL_INJECTION"      "query\s*[+]\s*.*req\."                        "$FILES"
check "SQL_INJECTION"      "\`SELECT.*\${.*}\`"                           "$FILES"

# XSS
check "XSS_RISK"           "dangerouslySetInnerHTML"                      "$FILES"
check "XSS_RISK"           "innerHTML\s*="                                "$FILES"

# Debug artifacts
check "DEBUG_ARTIFACT"     "console\.log"                                  "$FILES"
check "DEBUG_ARTIFACT"     "debugger"                                      "$FILES"

# Auth gaps
check "MISSING_AUTH"       "router\.(get|post|put|delete)\s*(['\"])" "$FILES"

# Report
if [ ${#ISSUES[@]} -eq 0 ]; then
  echo "  ✅ No security issues found"
  exit 0
else
  echo "  ❌ Security issues found:"
  for issue in "${ISSUES[@]}"; do
    echo "    - $issue"
  done
  exit 1
fi
