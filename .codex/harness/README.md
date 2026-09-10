# Harness Engineering — Execution Layer

The harness transforms structured PRPs into production-ready code through a
**Generator → Evaluator → Quality Gate** loop, then creates a PR automatically.

## How It Works

```
Developer writes PRP (YAML front-matter + prose)
           │
           ▼
./harness/harness-runner.sh prp/PRP-XXX.md
           │
    ┌──────┴──────────────────────────────────┐
    │  For each iteration (max_iterations):   │
    │                                         │
    │  Layer 1 ── Spec Compliance             │
    │    generator-agent  writes code         │
    │    evaluator-agent  scores vs ACs       │
    │    drift-detect     checks spec sync    │
    │                                         │
    │  Layer 2 ── Functional Correctness      │
    │    npm test         unit + integration  │
    │    tsc --noEmit     type check          │
    │    eslint           lint                │
    │                                         │
    │  Layer 3 ── System Behavior             │
    │    playwright       E2E critical flows  │
    │    contract-check   response vs spec    │
    │                                         │
    │  Layer 4 ── Production Readiness        │
    │    security-check   OWASP basics        │
    │    perf-benchmark   response thresholds │
    │                                         │
    │  score >= min_score?                    │
    │    YES → break, create PR               │
    │    NO  → feed eval-report back, retry  │
    └─────────────────────────────────────────┘
           │
           ▼
    gh pr create (with harness report in body)
```

## Files

| File | Purpose |
|------|---------|
| `harness-runner.sh` | Main orchestrator — runs all 4 layers |
| `generator-agent.md` | Agent prompt for code generation |
| `evaluator-agent.md` | Agent prompt for AC scoring |
| `security-check.sh` | Layer 4 security gate |
| `eval-report-schema.json` | Schema for evaluator output |

## Scripts (in `../scripts/`)

| Script | Purpose |
|--------|---------|
| `validate-prp.sh` | Validate PRP YAML front-matter against schema |
| `generate-test-stubs.sh` | Generate test skeleton from AC test_hints |
| `drift-detect-api.sh` | Detect divergence between api-spec.md and routes |
| `drift-detect-db.sh` | Detect divergence between db-design.md and migrations |
| `contract-validate.sh` | Validate live API response against spec schema |
| `perf-benchmark.sh` | Run response time benchmark |

## Quick Start

```bash
# 1. Validate your PRP
./scripts/validate-prp.sh prp/PRP-003-customer-list.md

# 2. Generate test stubs from ACs
./scripts/generate-test-stubs.sh prp/PRP-003-customer-list.md

# 3. Run the full harness
./harness/harness-runner.sh prp/PRP-003-customer-list.md

# 4. Review the result
cat harness/eval-report.json
```

## Quality Score Interpretation

| Score | Meaning | Action |
|-------|---------|--------|
| 90–100 | All ACs fully met | Auto-PR created |
| 80–89 | ACs met, minor gaps | Auto-PR created |
| 70–79 | Partial, below threshold | Retry (if iterations remain) |
| < 70 | Significant gaps | Retry or human review |

## Confidence Stack

```
Spec is correct      ← human writes good ACs in PRP
Code matches spec    ← Layer 1 (evaluator + drift)
Code works           ← Layer 2 (unit + integration + types)
System works         ← Layer 3 (E2E + contracts)
Safe to ship         ← Layer 4 (security + performance)
GO-LIVE              ← canary deploy → monitor → full rollout
```
