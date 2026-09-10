# Project Brief

> **BMAD Phase: Pre-Sprint 0**
> The Project Brief is the entry point for the BMAD workflow. Fill this in during the initial product conversation
> before creating the PRD. It gives every AI persona (Analyst, Architect, Developer) the shared context they need.
>
> When complete, this document drives: PRD · Architecture · Epic/Story breakdown · CLAUDE.md first draft.

| Item | Content |
|------|---------|
| Project Name | |
| Version | 0.1 |
| Created Date | |
| Author | |
| Status | Draft / Approved |

---

## 1. Problem Statement

<!-- 2–3 sentences: what pain or gap does this product address? -->
<!-- Focus on the user's problem, not the solution. -->

**Who is affected:**

**Current situation (As-Is):**

**Pain / cost of the current situation:**

---

## 2. Proposed Solution

<!-- 1 paragraph: what we are building and the core mechanism that solves the problem -->

**Core mechanism:**

**Why this approach over alternatives:**

---

## 3. Product Vision

<!-- One-sentence north star. Should be memorable and testable in 12 months. -->

> "For [target users] who [need X], [Product Name] is [product category] that [key benefit]. Unlike [alternative], our product [differentiator]."

---

## 4. Target Users (Personas)

| Persona | Role | Primary Goal | Key Frustration |
|---------|------|-------------|-----------------|
| P-01 | | | |
| P-02 | | | |

---

## 5. Goals & Success Metrics

<!-- Outcome-based. Each goal should be falsifiable in 3–6 months. -->

| Goal ID | Goal | Metric | Target | Baseline |
|---------|------|--------|--------|---------|
| G-01 | | | | |
| G-02 | | | | |

---

## 6. Scope

### In Scope (v1.0)
-
-

### Out of Scope (explicitly deferred)
-
-

### Known Unknowns (to resolve in Sprint 0)
-
-

---

## 7. Epic Overview

> Full stories are defined in `tpl/story_en.md` per story file.
> Epics here are named groupings only — they become sections in the PRD.

| Epic ID | Epic Name | Description | BMAD Persona Lead | Priority |
|---------|-----------|------------|-------------------|---------|
| EP-01 | | | Analyst / PM | Must |
| EP-02 | | | Architect | Must |
| EP-03 | | | Developer | Should |

---

## 8. High-Level Technical Considerations

<!-- Constraints the Architect must know before designing. Not decisions — inputs. -->

- **Platform**: Web / Mobile / Desktop / API-only
- **Existing systems to integrate**:
- **Data residency / compliance**:
- **Performance envelope** (e.g., < 2s p95, 10k concurrent users):
- **Team tech familiarity** (languages, frameworks):
- **Hard constraints** (budget, timeline, licensing):

---

## 9. BMAD Persona Assignments

> Assign the AI persona responsible for each phase. Used to route tasks to the right agent.

| Phase | BMAD Persona | Superpowers Skill | Owner |
|-------|-------------|-------------------|-------|
| Requirements Definition | Analyst | `/brainstorming` → `prp-plan` | |
| Architecture & Design | Architect | `/writing-plans` → `prp-plan` | |
| Story Breakdown | Product Manager | `prp-plan` per story | |
| Implementation | Developer | `prp-implement` + `/test-driven-development` | |
| Code Review | Senior Developer | `/requesting-code-review` | |
| QA / Acceptance | QA Engineer | `/verification-before-completion` | |
| Release | Tech Lead | `/finishing-a-development-branch` | |

---

## 10. Constraints & Assumptions

| Type | Description |
|------|------------|
| Constraint | |
| Assumption | |
| Dependency | |
| Risk | |

---

## Approval

| Role | Name | Signature | Date |
|------|------|-----------|------|
| Product Owner | | | |
| Tech Lead | | | |

---

## Document History

| Version | Date | Author | Content |
|---------|------|--------|---------|
| 0.1 | | | Initial brief |
| 1.0 | | | Approved — ready for Sprint 0 |
