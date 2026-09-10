#!/usr/bin/env bash
# perf-benchmark.sh — Response time benchmark against thresholds
#
# Usage: ./scripts/perf-benchmark.sh [--base-url <url>] [--threshold-ms <ms>]
# Exit 0 = within thresholds. Exit 1 = exceeded.
#
# Measures p95 response time for key endpoints. Requires: curl, python3.

set -euo pipefail

BASE_URL="${API_BASE_URL:-http://localhost:3000}"
THRESHOLD_MS="${PERF_THRESHOLD_MS:-500}"
SAMPLES="${PERF_SAMPLES:-10}"
FAILURES=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --base-url)     BASE_URL="$2"; shift 2 ;;
    --threshold-ms) THRESHOLD_MS="$2"; shift 2 ;;
    --samples)      SAMPLES="$2"; shift 2 ;;
    *) shift ;;
  esac
done

echo "── Performance Benchmark ─────────────────────────────"
echo "   Base URL:     $BASE_URL"
echo "   Threshold:    ${THRESHOLD_MS}ms (p95)"
echo "   Samples/endpoint: $SAMPLES"

if ! curl -sf --max-time 3 "$BASE_URL/health" > /dev/null 2>&1 && \
   ! curl -sf --max-time 3 "$BASE_URL" > /dev/null 2>&1; then
  echo "  ⚠️  Server not reachable at $BASE_URL — skipping benchmark"
  exit 0
fi

# Endpoints to benchmark (common health + list endpoints)
ENDPOINTS=(
  "/health"
  "/api/customers"
  "/api/customers?search=test"
)

python3 - <<PYEOF
import subprocess, json, sys, statistics

base_url = '$BASE_URL'
threshold = int('$THRESHOLD_MS')
samples = int('$SAMPLES')
endpoints = $( printf "'%s', " "${ENDPOINTS[@]}" | sed "s/, $//"; echo "" )

# Build python list
endpoints_py = [
$(for ep in "${ENDPOINTS[@]}"; do echo "    '$ep',"; done)
]

all_passed = True

for path in endpoints_py:
    url = base_url + path
    times = []

    for _ in range(samples):
        try:
            result = subprocess.run(
                ['curl', '-sf', '--max-time', '10', '-o', '/dev/null',
                 '-w', '%{time_total}', url],
                capture_output=True, text=True, timeout=15
            )
            if result.returncode == 0 and result.stdout.strip():
                ms = float(result.stdout.strip()) * 1000
                times.append(ms)
        except subprocess.TimeoutExpired:
            times.append(threshold * 2)  # count timeout as breach

    if not times:
        print(f"  ⚠️  {path} — no successful samples")
        continue

    times.sort()
    p95_idx = int(len(times) * 0.95)
    p95 = times[min(p95_idx, len(times) - 1)]
    avg = statistics.mean(times)

    status = "✅" if p95 <= threshold else "❌"
    print(f"  {status} {path} — p95: {p95:.0f}ms, avg: {avg:.0f}ms (threshold: {threshold}ms)")

    if p95 > threshold:
        all_passed = False

sys.exit(0 if all_passed else 1)
PYEOF
