# PRP (Product Requirements Prompt) Template

> AI implementation instruction document. Managed as 1 task = 1 file.
> The YAML front-matter is parsed by the harness runner to drive automated
> generation, evaluation, and quality gating. The prose sections guide the
> generator agent.
>
> Filename: `prp/PRP-<task-id>-<feature-name>.md`

---

```markdown
---
task_id: SCR-001
story_id: EP-01-US-001        # BMAD story file this PRP implements (omit if no story file)
title: Feature Name
clarification_policy: |
  Before writing any code, check whether the overview, every acceptance
  criterion, and every dependency reference is clear and unambiguous.
  If anything is missing or unclear, output a QUESTIONS: block (numbered list)
  and stop. Do not assume and proceed. Wait for answers before implementing.
target_files:
  - src/pages/FeaturePage.tsx
  - src/hooks/useFeature.ts
acceptance_criteria:
  - id: AC-1
    description: One sentence describing the observable behavior
    type: functional        # functional | integration | visual | performance | security
    test_hint: "render with X, assert Y is visible"
  - id: AC-2
    description: Another behavior
    type: functional
    test_hint: "mock empty response, assert empty state text"
  - id: AC-3
    description: Security requirement
    type: security
    test_hint: "send unauthenticated request, assert 401"
quality_gate:
  min_score: 80           # 0–100, harness retries until score >= this
  max_iterations: 3       # max generator-evaluator cycles before human review
dependencies:
  specs:
    - docs/api-spec.md#ENDPOINT
    - docs/screen-design.md#SCREEN-ID
    - docs/srs.md#section   # non-functional constraints relevant to this task
  code:
    - src/components/ui/ExistingComponent.tsx
    - src/hooks/useExistingHook.ts
---

# Task: (Task Name)

## Overview

(1–2 sentences: what this task implements and why — generator agent reads this first)

## Target Files

- `src/pages/CustomerList.tsx` (new file)
- `src/api/customers.ts` (append to existing file)

## Existing Code References

<!-- Explicitly list existing files, functions, and patterns to read before implementation -->

- `src/components/ui/DataTable.tsx` — Existing table component (reuse as-is)
- `src/api/products.ts` — Similar API client implementation pattern (use as reference)
- `src/hooks/usePagination.ts` — Existing pagination hook (use directly)

## Referenced Design Documents

- [Screen Design SCR-XXX](../docs/screen-design.md)
- [API Specification](../docs/api-spec.md)
- [Non-Functional Requirements (SRS)](../docs/srs.md)

## Technical Specifications

- Component name: `CustomerList`
- API used: `GET /api/customers?name=XX&page=1&limit=20`
- State management: Zustand (`useCustomerStore`)
- Validation: Not required (search is optional input)

## Implementation Hints

<!-- Positive guidance only: libraries to use, patterns, known pitfalls -->
<!-- Prohibited items go in the next section -->

- Use the existing `usePagination` hook (`src/hooks/usePagination.ts`) for pagination
- Reuse the `<Spinner />` component (`src/components/ui/Spinner.tsx`) for loading state
- Standardize API error display using the `useErrorToast()` hook
- Use `date-fns/format` for date formatting (do not use `dayjs`)

## Task-Specific Prohibited Items

<!-- In addition to the common prohibited items in CLAUDE.md -->

- Do not modify the existing `DataTable` component (wrap it in a new component instead)
- Do not fetch directly in `useEffect` (go through actions in `useCustomerStore`)
- Do not use inline styles

## Constraints / Notes

- Reuse the existing `Button` component
- Use CSS variables from `src/styles/tokens.css` for design
- Do not use the `any` type

## Test Requirements

- Write unit tests that verify each acceptance criterion
- Test the display when there are 0 results
- Test pagination behavior

## Post-Completion Actions

1. Run `./harness/harness-runner.sh prp/PRP-<id>.md`
2. Review `harness/eval-report.json` if score < 80
3. Run `code-reviewer` SubAgent before creating PR
4. Run `security-reviewer` SubAgent if input handling is involved
5. Mark all acceptance criteria in this PRP file as checked
6. Merge the auto-created PR after team review
```

---

## AC Type Reference

| Type | What it covers | Test approach |
|------|---------------|---------------|
| `functional` | UI behavior, business logic | Unit test with mocked deps |
| `integration` | Real API/DB interaction | Integration test, dev server |
| `visual` | Layout, responsive design | Playwright screenshot + diff |
| `performance` | Response time, bundle size | Benchmark with threshold |
| `security` | Auth, input validation, injection | Fuzzing + auth check |

## Quality Gate Reference

| `min_score` | Appropriate for |
|-------------|----------------|
| 70 | Prototype / spike |
| 80 | Standard feature (recommended default) |
| 90 | Security-sensitive or payment flows |
| 95 | Core auth, data migration |
