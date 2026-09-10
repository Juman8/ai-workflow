# Multi-Repository Structure Guidelines

This guideline summarizes the split repository structure for infrastructure, API, web, and mobile in AI-driven development, and how to manage shared documents.

---

## Overall Picture

```
org/
├── project-docs/          # Shared Specifications (source for all repositories)
├── project-infra/         # Infrastructure (Terraform / CDK / K8s)
├── project-api/           # Backend API
├── project-web/           # Web Frontend
└── project-app/           # Mobile App (iOS/Android)
```

---

## `project-docs/` (Shared Specifications)

A single source of truth for specifications referenced by all repositories. Create each file by copying templates from `tpl/`.

```
project-docs/
├── README.md                              # Specification list and update rules
│
├── requirements/                          # Phase 1: Requirements Definition
│   ├── prd.md                             # Created from tpl/prd.md
│   ├── srs.md                             # Created from tpl/srs.md
│   ├── business-flow.md                   # Created from tpl/business-flow.md
│   ├── migration-requirements.md          # Created from tpl/migration-requirements.md (if migration is involved)
│   └── operations-requirements.md        # Created from tpl/operations-requirements.md
│
├── estimate/                              # Phase 1.5: Effort Estimation
│   └── estimate.md                        # Created from tpl/estimate.md
│
├── design/                                # Phase 2: Design
│   ├── architecture.md                    # Created from tpl/architecture.md
│   ├── db-design.md                       # Created from tpl/db-design.md
│   ├── api-spec.md                        # Created from tpl/api-spec.md ★Shared across all repositories
│   ├── screen-design/
│   │   ├── web/                           # Created from tpl/screen-design.md (for Web)
│   │   │   └── screen-design.md
│   │   └── app/                           # Created from tpl/screen-design.md (for Mobile)
│   │       └── screen-design.md
│   └── adr/                               # Created from tpl/adr.md
│       ├── ADR-001-api-framework.md
│       └── ADR-002-mobile-framework.md
│
├── sprint/                                # Sprint Management (Agile)
│   ├── sprint-backlog.md                  # Created from tpl/sprint-backlog.md
│   ├── retrospective.md                   # Created from tpl/retrospective.md
│   ├── issue-tracker.md                   # Created from tpl/issue-tracker.md
│   └── meeting-minutes/                   # Created from tpl/meeting-minutes.md
│       └── YYYY-MM-DD.md
│
├── ai-dev/                                # Phase 3: AI Development Preparation
│   ├── ai-coding-standards.md             # Created from tpl/ai-coding-standards.md
│   └── ai-metrics.md                      # Created from tpl/ai-metrics.md
│
├── cross-repo/                            # Cross-repository tasks spanning multiple repositories
│   └── TASK-015-add-search-api.md
│
├── testing/                               # Phase 5: Testing
│   ├── test-plan.md                       # Created from tpl/test-plan.md
│   ├── test-cases.md                      # Created from tpl/test-cases.md
│   ├── test-report.md                     # Created from tpl/test-report.md
│   └── bug-tracker.md                     # Created from tpl/bug-tracker.md
│
└── delivery/                              # Phase 6: Delivery
    ├── release-notes.md                   # Created from tpl/release-notes.md
    ├── user-manual.md                     # Created from tpl/user-manual.md
    ├── admin-manual.md                    # Created from tpl/admin-manual.md
    └── acceptance.md                      # Created from tpl/acceptance.md
```

### Template → Specification Mapping

| Specification | Used Template | Creation Phase |
|---|---|---|
| `requirements/prd.md` | `tpl/prd.md` | Phase 1 |
| `requirements/srs.md` | `tpl/srs.md` | Phase 1 |
| `requirements/business-flow.md` | `tpl/business-flow.md` | Phase 1 |
| `requirements/migration-requirements.md` | `tpl/migration-requirements.md` | Phase 1 (if migration is involved) |
| `requirements/operations-requirements.md` | `tpl/operations-requirements.md` | Phase 1 |
| `estimate/estimate.md` | `tpl/estimate.md` | Phase 1.5 |
| `design/architecture.md` | `tpl/architecture.md` | Phase 2 |
| `design/db-design.md` | `tpl/db-design.md` | Phase 2 |
| `design/api-spec.md` | `tpl/api-spec.md` | Phase 2 |
| `design/screen-design/` | `tpl/screen-design.md` | Phase 2 |
| `design/adr/` | `tpl/adr.md` | Phase 2 |
| `sprint/sprint-backlog.md` | `tpl/sprint-backlog.md` | Per Sprint |
| `sprint/retrospective.md` | `tpl/retrospective.md` | Per Sprint |
| `sprint/issue-tracker.md` | `tpl/issue-tracker.md` | All Periods |
| `sprint/meeting-minutes/` | `tpl/meeting-minutes.md` | All Periods |
| `ai-dev/ai-coding-standards.md` | `tpl/ai-coding-standards.md` | Phase 3 |
| `ai-dev/ai-metrics.md` | `tpl/ai-metrics.md` | Phase 3 |
| `testing/test-plan.md` | `tpl/test-plan.md` | Phase 5 |
| `testing/test-cases.md` | `tpl/test-cases.md` | Phase 5 |
| `testing/test-report.md` | `tpl/test-report.md` | Phase 5 |
| `testing/bug-tracker.md` | `tpl/bug-tracker.md` | Phase 5 |
| `delivery/release-notes.md` | `tpl/release-notes.md` | Phase 6 |
| `delivery/user-manual.md` | `tpl/user-manual.md` | Phase 6 |
| `delivery/admin-manual.md` | `tpl/admin-manual.md` | Phase 6 |
| `delivery/acceptance.md` | `tpl/acceptance.md` | Phase 6 |

### Specification Owners and Update Rules

| Specification | Owner | Update Trigger |
|---|---|---|
| `prd.md` / `srs.md` | PM / Requirements Lead | Upon requirement change |
| `api-spec.md` | API Team | Upon API endpoint addition or change |
| `db-design.md` | API Team | Upon table or column change |
| `architecture.md` | Infra / API Team | Upon architectural change |
| `screen-design/web/` | Web Team | Upon screen addition or change |
| `screen-design/app/` | Mobile Team | Upon screen addition or change |
| `bug-tracker.md` | All Teams | Upon bug occurrence or resolution |
| `sprint-backlog.md` | Scrum Master | Per sprint |

### Specification Synchronization Flow

```
api-spec.md in project-docs is updated
    │
    ▼
CI (sync-docs.yml) runs automatically
    ├── Updates project-api/docs/api-spec.local.md and creates a PR
    ├── Updates project-web/docs/api-spec.local.md and creates a PR
    └── Updates project-app/docs/api-spec.local.md and creates a PR
    │
    ▼
Each team reviews and merges the PR
    │
    ▼
AI references docs/api-spec.local.md in each repository for implementation
```

---

## `project-infra/`

```
project-infra/
├── CLAUDE.md                              # Created from tpl/claude-md.md (Infra-specific)
├── .claudeignore                          # Created based on tpl/claudeignore-sample.md
│
├── terraform/
│   ├── environments/
│   │   ├── dev/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── terraform.tfvars
│   │   ├── stg/
│   │   └── prd/
│   └── modules/
│       ├── vpc/
│       ├── rds/
│       ├── ecs/
│       └── cdn/
│
├── k8s/                                   # If Kubernetes is used
│   ├── base/
│   └── overlays/
│
├── docs/                                  # Infra-specific documents (copy of shared specs)
│   ├── architecture.local.md              # ← Copy of project-docs/design/architecture.md
│   ├── env-setup.md                       # Created from tpl/env-setup.md
│   └── operations-requirements.local.md   # ← Copy of project-docs/requirements/operations-requirements.md
│
├── prp/                                   # Created from tpl/prp.md (per task)
│   ├── PRP-001-setup-vpc.md
│   └── PRP-002-setup-rds.md
│
└── .github/
    └── workflows/
        ├── terraform-plan.yml
        └── sync-docs.yml                  # Sync from project-docs
```

### Key Points of CLAUDE.md (infra)

```markdown
## Referenced Shared Specifications
- System Architecture: docs/architecture.local.md
- Non-functional Requirements (SLA, Scaling): ../project-docs/requirements/srs.md
- Operations Requirements: docs/operations-requirements.local.md

## Responsibilities of this Repository
- Provisioning of VPC, RDS, ECS, CDN
- Configuration management of environments (dev/stg/prd)

## Boundaries with Other Repositories
- Application code implementation → Each application repository

## Prohibited Actions
- Do not place application code here
- Always confirm plan before applying changes to production
- Do not hardcode credentials/secrets in the code
```

---

## `project-api/`

```
project-api/
├── CLAUDE.md                              # Created from tpl/claude-md.md (API-specific)
├── .claudeignore                          # Created based on tpl/claudeignore-sample.md
│
├── src/
│   ├── routes/                            # API Routes
│   ├── controllers/
│   ├── services/
│   ├── repositories/                      # DB Operations
│   ├── models/                            # Type Definitions / Schemas
│   └── middleware/                        # Authentication / Validation
│
├── migrations/                            # DB Migrations
│
├── tests/
│   ├── unit/
│   ├── integration/
│   └── fixtures/
│
├── docs/                                  # Local copy of shared specs (synced by CI)
│   ├── api-spec.local.md                  # ← project-docs/design/api-spec.md
│   ├── db-design.local.md                 # ← project-docs/design/db-design.md
│   └── srs.local.md                       # ← project-docs/requirements/srs.md
│
├── prp/                                   # Created from tpl/prp.md (per task)
│   ├── PRP-001-user-auth.md
│   ├── PRP-002-customer-search.md
│   └── PRP-003-order-api.md
│
└── .github/
    └── workflows/
        ├── ci.yml
        └── sync-docs.yml                  # PR creation to project-docs for api-spec.md changes
```

### Key Points of CLAUDE.md (api)

```markdown
## Referenced Shared Specifications
- API Specification: docs/api-spec.local.md
- DB Design: docs/db-design.local.md
- Non-functional Requirements: docs/srs.local.md

## AI Coding Standards
- Follow ../project-docs/ai-dev/ai-coding-standards.md

## Responsibilities of this Repository
- REST API implementation (Node.js / Express)
- DB operations and business logic

## Boundaries with Other Repositories
- Infrastructure (RDS connection, ECS settings) → project-infra
- UI implementation → Not done in this repository

## Prohibited Actions
- Do not place frontend code here
- Do not hardcode environment variables outside of .env
```

---

## `project-web/`

```
project-web/
├── CLAUDE.md                              # Created from tpl/claude-md.md (Web-specific)
├── .claudeignore                          # Created based on tpl/claudeignore-sample.md
│
├── src/
│   ├── app/                               # Next.js App Router or pages/
│   ├── components/
│   │   ├── ui/                            # Generic Components
│   │   └── features/                      # Feature-specific Components
│   ├── hooks/
│   ├── lib/
│   │   └── api-client/                    # Communication client to project-api
│   ├── stores/                            # State Management
│   └── styles/
│
├── tests/
│   ├── unit/
│   ├── e2e/                               # Playwright
│   └── visual/                            # Screenshot Testing
│
├── docs/                                  # Local copy of shared specs (synced by CI)
│   ├── screen-design.local.md             # ← project-docs/design/screen-design/web/
│   └── api-spec.local.md                  # ← project-docs/design/api-spec.md
│
├── prp/                                   # Created from tpl/prp.md (per task)
│   ├── PRP-001-login-screen.md
│   └── PRP-002-customer-list.md
│
└── .github/
    └── workflows/
        ├── ci.yml
        └── sync-docs.yml
```

### Key Points of CLAUDE.md (web)

```markdown
## Referenced Shared Specifications
- Screen Design: docs/screen-design.local.md
- API Specification: docs/api-spec.local.md

## AI Coding Standards
- Follow ../project-docs/ai-dev/ai-coding-standards.md

## Responsibilities of this Repository
- Web UI implementation (Next.js / React)
- Communication with project-api (src/lib/api-client/)

## Boundaries with Other Repositories
- API implementation → project-api
- Infrastructure → project-infra
- Mobile UI → project-app (components are not shared)

## Prohibited Actions
- Do not write API business logic in the frontend
- Do not call `fetch` directly outside of src/lib/api-client/
```

---

## `project-app/`

```
project-app/
├── CLAUDE.md                              # Created from tpl/claude-md.md (Mobile-specific)
├── .claudeignore                          # Created based on tpl/claudeignore-sample.md
│
├── src/                                   # Flutter or React Native
│   ├── screens/                           # Screens
│   ├── components/                        # Common Components
│   ├── navigation/                        # Screen Navigation
│   ├── services/
│   │   └── api-client/                    # Communication client to project-api
│   ├── stores/                            # State Management
│   └── assets/
│
├── ios/
├── android/
│
├── tests/
│   ├── unit/
│   └── e2e/                               # Detox or Maestro
│
├── docs/                                  # Local copy of shared specs (synced by CI)
│   ├── screen-design.local.md             # ← project-docs/design/screen-design/app/
│   └── api-spec.local.md                  # ← project-docs/design/api-spec.md
│
├── prp/                                   # Created from tpl/prp.md (per task)
│   ├── PRP-001-login-screen.md
│   └── PRP-002-push-notification.md
│
└── .github/
    └── workflows/
        ├── ci.yml
        └── sync-docs.yml
```

### Key Points of CLAUDE.md (app)

```markdown
## Referenced Shared Specifications
- Screen Design: docs/screen-design.local.md
- API Specification: docs/api-spec.local.md

## AI Coding Standards
- Follow ../project-docs/ai-dev/ai-coding-standards.md

## Responsibilities of this Repository
- iOS / Android app implementation (Flutter)
- Communication with project-api (src/services/api-client/)

## Boundaries with Other Repositories
- API implementation → project-api
- Web UI → project-web (components are not shared)

## Prohibited Actions
- Do not write platform-specific code directly under src/
- Do not hardcode API keys in the source code
```

---

## Handling Cross-Repository Tasks

Tasks spanning multiple repositories, such as API additions, are managed centrally in `project-docs/cross-repo/`.

```markdown
# TASK-015-add-search-api.md (Example of Cross-Repository Task Instruction)

## Overview
Addition of customer search API (affects project-api, project-web, and project-app repositories)

## Tasks per Repository
- project-api: Add GET /api/customers?q= endpoint (refer to prp/PRP-015)
- project-web: Add search screen (refer to prp/PRP-023)
- project-app: Add search screen (refer to prp/PRP-018)

## Implementation Order
1. Implement the endpoint in project-api
2. Update project-docs/design/api-spec.md
3. CI creates PRs for api-spec.local.md updates in project-web / project-app
4. Each team starts UI implementation after merging the PRs
```

---

## Caveats for Multi-Repository × AI Development

| Issue | Countermeasure |
|---|---|
| AI is unaware of code in other repositories | Clearly state boundaries and references in `CLAUDE.md` |
| API specifications drift in each repository | Use `project-docs` as the single source and sync to each repository via CI |
| Dependencies are difficult to understand when creating PRP | Clearly state "repositories/files that this task depends on" in the PRP |
| Reviewers find it hard to grasp cross-cutting changes | Record affected repositories in `issue-tracker.md` |
| Unsure from which repository to update CLAUDE.md | Update `CLAUDE.md` in that repository immediately after code changes |
| Difficulty in seeing the effects of AI utilization | Record sprint-by-sprint metrics in `ai-metrics.md` |

---

## Checklist

### When Starting a New Project

**Prepare `project-docs`**
- [ ] Have you created `requirements/prd.md` by copying `tpl/prd.md`?
- [ ] Have you created `requirements/srs.md` by copying `tpl/srs.md`?
- [ ] Have you created `design/architecture.md` by copying `tpl/architecture.md`?
- [ ] Have you created `design/db-design.md` by copying `tpl/db-design.md`?
- [ ] Have you created `design/api-spec.md` by copying `tpl/api-spec.md`?
- [ ] Have you created `design/screen-design/web/` and `design/screen-design/app/` by copying `tpl/screen-design.md`?
- [ ] Have you created `ai-dev/ai-coding-standards.md` by copying `tpl/ai-coding-standards.md`?
- [ ] Have you created `ai-dev/ai-metrics.md` by copying `tpl/ai-metrics.md`?
- [ ] Have you created `sprint/sprint-backlog.md` by copying `tpl/sprint-backlog.md`?
- [ ] Have you created `testing/bug-tracker.md` by copying `tpl/bug-tracker.md`?

**Prepare each application repository**
- [ ] Have you created and customized `CLAUDE.md` by copying `tpl/claude-md.md`?
- [ ] Have you created `.claudeignore` based on `tpl/claudeignore-sample.md`?
- [ ] Have you placed local copies of shared specifications in `docs/`?
- [ ] Have you configured the sync workflow from `project-docs` in CI?
- [ ] Are you using `tpl/prp.md` as a template when creating PRPs?

### At the Start of a Sprint

- [ ] Have you added new sprint rows to `tpl/sprint-backlog.md`?
- [ ] Have you created PRPs for each user story based on `tpl/prp.md`?
- [ ] Have you updated SP estimates in `tpl/estimate.md`?

### Upon API Specification Change

- [ ] Have you updated `project-docs/design/api-spec.md`?
- [ ] Has CI created sync PRs for project-api / project-web / project-app?
- [ ] Has each team reviewed and merged the sync PRs?

### At the End of a Sprint

- [ ] Have you recorded the retrospective based on `tpl/retrospective.md`?
- [ ] Have you passed the git log to the AI to differentially update `design/api-spec.md` / `design/db-design.md`?
- [ ] Have you updated the test result report based on `tpl/test-report.md`?
- [ ] Have you updated bug statuses in `tpl/bug-tracker.md`?
- [ ] Have you recorded sprint achievements in `ai-metrics.md`?

### Upon Release/Delivery

- [ ] Have you finalized the test result report based on `tpl/test-report.md`?
- [ ] Have you created manuals based on `tpl/user-manual.md` / `tpl/admin-manual.md`?
- [ ] Have you created release notes based on `tpl/release-notes.md`?
- [ ] Have you created the acceptance confirmation and obtained signatures based on `tpl/acceptance.md`?
