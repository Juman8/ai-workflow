# Story {EPIC-ID}-{STORY-ID}: {Title}

> **BMAD Phase: Sprint N**
> One story file per user story. Created by the PM persona from the Epic definition.
> This file is the contract between BMAD story breakdown and Superpowers PRP execution.
>
> File naming: `stories/EP-01-US-001-{slug}.md`

| Field | Value |
|-------|-------|
| Story ID | EP-01-US-001 |
| Epic | EP-01: {Epic Name} |
| Sprint | Sprint N |
| Status | Draft → Approved → In-Progress → Review → Done |
| Story Points | |
| Owner | |
| Reviewer | |
| PRP File | `prp/EP-01-US-001-{slug}.md` |
| Created | |
| Updated | |

---

## Story

As a **{persona/role}**,
I want **{capability or feature}**,
so that **{business value / outcome}**.

---

## Acceptance Criteria

> Format: Given / When / Then.
> Each AC maps directly to a `test_hint` in the PRP YAML front-matter.
> Number them — the PRP references these by number (AC-1, AC-2, ...).

**AC-1:** Given {context/precondition}, when {action/trigger}, then {expected outcome}.

**AC-2:** Given {context}, when {action}, then {outcome}.

**AC-3:** Given {context}, when {action}, then {outcome}.

> **Edge cases / error scenarios**

**AC-4 (Error):** Given {error context}, when {invalid input or failure}, then {graceful handling}.

---

## Tasks

> Break the story into implementation tasks. Each task should be completable in < 2 hours.
> The Developer persona (or Superpowers `prp-implement`) picks these up directly.

### Task 1: {Setup / Prerequisites}
- [ ] {Specific subtask}
- [ ] {Specific subtask}

### Task 2: {Core Implementation}
- [ ] {Specific subtask}
- [ ] {Specific subtask}
- [ ] {Specific subtask}

### Task 3: {Tests}
- [ ] Write unit tests for AC-1, AC-2
- [ ] Write integration test for AC-3
- [ ] Verify coverage ≥ 80%

### Task 4: {Cleanup / Review}
- [ ] Self-review against AC checklist
- [ ] Remove debug code
- [ ] Update relevant documentation

---

## Dev Notes

> Context the AI Developer persona needs to implement this story correctly.
> Reduces clarification loops. Written by the Architect or Senior Dev persona.

### Architecture Context
<!-- Which layer does this touch? (API, service, repository, UI component?) -->
<!-- What existing patterns should be followed? -->

### Files to Create or Modify
| Action | File Path | Purpose |
|--------|-----------|---------|
| Create | `src/` | |
| Modify | `src/` | |
| Test | `__tests__/` | |

### Existing Patterns to Follow
<!-- Point to concrete files in the codebase that exemplify the right approach. -->
- `src/path/to/example.ts` — follow this pattern for {reason}

### Data Contracts
<!-- API request/response shapes, DB schema fragments, or type definitions relevant here. -->

```typescript
// Example interface or type
```

### Known Constraints
<!-- Hard constraints the developer must not violate. -->
-

### Out of Scope for This Story
<!-- Explicitly call out what is NOT included, to prevent scope creep. -->
-

---

## Definition of Done (Story-Level)

- [ ] All ACs verified (manual or automated)
- [ ] All tasks checked off
- [ ] Tests pass with ≥ 80% coverage
- [ ] Code reviewed and approved
- [ ] No lint / type errors
- [ ] PRP `quality_gate.min_score` reached (if harness was used)
- [ ] Story status set to **Done** in sprint backlog

---

## PRP Reference

> The PRP translates this story's ACs into harness-executable YAML.
> Do not duplicate content here — the PRP is the single source of truth for execution.

→ [`prp/EP-01-US-001-{slug}.md`](../prp/EP-01-US-001-{slug}.md)

**PRP Status:** Not Created / Draft / Ready / In-Progress / Complete

---

## Conversation Log

> Optional: record key decisions made in the PM / Architect persona conversation
> that led to this story's current shape. Helps future reviewers understand WHY.

| # | Persona | Decision / Note |
|---|---------|----------------|
| 1 | PM | Initial story drafted from Epic EP-01 |
| 2 | Architect | Defined data contract and file targets |
| 3 | Dev | Added task breakdown and dev notes |
