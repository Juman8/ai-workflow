# CLAUDE.md (AI Context Document) Template

> Place this file as `CLAUDE.md` in the project root.
> AI tools (such as Claude Code) will automatically load it to understand the project context.

---

```markdown
# Project Overview

(Describe the purpose of the system in 1–2 sentences)

# Tech Stack

- Frontend: React + TypeScript
- Backend: Node.js + Express
- Database: PostgreSQL
- ORM: Prisma
- Testing: Jest + Playwright
- CI/CD: GitHub Actions

# Directory Structure

src/
├── components/   # UI components
├── pages/        # Page components
├── api/          # API routers
├── db/           # DB schema · migrations
├── lib/          # Common utilities
└── types/        # Type definitions

docs/
├── prp/          # PRP (AI implementation instructions): prp-<screen-id>-<feature-name>.md
└── tpl/          # Document templates

# Coding Standards

- Use TypeScript strict mode
- Keep functions within 50 lines
- Keep files within 800 lines
- Use immutable patterns (direct object mutation is prohibited)
- Always implement error handling
- Prohibit use of the `any` type

# Libraries in Use

- State management: Zustand (Redux is prohibited)
- Forms: React Hook Form
- HTTP client: Axios
- Validation: Zod

# Clarification Policy

Before starting any implementation task, check:
- Is the task description unambiguous and complete?
- Are all referenced docs, specs, or files available?
- Are acceptance criteria concrete and testable?
- Does the request contain any placeholder text (`TODO`, `TBD`, `<…>`)?

If **any** check fails, output a `QUESTIONS:` block with a numbered list of
specific questions and **stop**. Do not guess or fill in assumptions silently.
Wait for answers before writing code.

# Prohibited Items

- Do not leave `console.log` in production code
- Do not include hardcoded credentials or API keys
- Do not write string-concatenation queries that risk SQL injection
- Do not use the `any` type
- Do not install new libraries not listed in CLAUDE.md

# Security

- Always validate user input
- Use parameterized queries for SQL
- Add authentication guards to APIs that require authentication

# Testing Policy

- Write tests first for new features (TDD)
- Maintain 80%+ coverage
- Create E2E tests with Playwright

# Branch Strategy

- `main`: Production release branch (direct commits prohibited)
- `develop`: Development integration branch
- `feature/<screen-id>-<feature-name>`: Feature development branch (e.g., `feature/SCR-003-customer-list`)
- `fix/<bug-id>-<summary>`: Bug fix branch (e.g., `fix/BUG-012-login-error`)
- All PRs should target `develop`

# SubAgent Configuration

Use the following SubAgents according to their purpose:

| SubAgent | Purpose | When to Invoke |
|----------|---------|---------------|
| code-reviewer | Code review · quality check | After implementation · before PR creation |
| security-reviewer | Security vulnerability check | When auth or input handling changes |
| build-error-resolver | Resolve build errors | When build fails |
| tdd-guide | TDD support | For new features · bug fixes |

# Skill Configuration

| Skill | Purpose |
|-------|---------|
| /commit | Diff analysis · commit message generation |
| /review-pr | PR review support |
| /plan | Create implementation plan |
| /tdd | Test-driven development cycle support |

# PRP (AI Implementation Instructions) Operations

- Manage as 1 task = 1 PRP file
- Storage location: `docs/prp/`
- Filename format: `prp-<screen-id>-<feature-name>.md` (e.g., `prp-SCR-003-customer-list.md`)
- Always create and review a PRP before starting implementation

# .claudeignore Reference

Specify files that AI should not read in `.claudeignore` to reduce token consumption.
Sample: see `docs/tpl/claudeignore-sample.md`.

# Common Commands

<!-- List commands frequently used in the project so AI can run them without hesitation -->

| Command | Description |
|---------|------------|
| `npm run dev` | Start development server |
| `npm test` | Run unit tests (Jest) |
| `npm run test:e2e` | Run E2E tests (Playwright) |
| `npm run build` | Production build |
| `npm run lint` | ESLint check |
| `npm run format` | Apply Prettier formatting |
| `npx prisma migrate dev` | Run DB migration (development environment) |
| `npx prisma studio` | Launch Prisma Studio (DB visualizer) |
| `npm run typecheck` | TypeScript type check (`tsc --noEmit`) |

# Project-Specific Glossary

<!-- Define domain terms so AI understands them correctly. Always include ambiguous terms. -->

| Term | Definition | Notes |
|------|-----------|-------|
| Customer | Refers to XX in this system | Maps to the `customers` table |
| Project | Unit of XX | Maps to the `projects` table |
| (Example) Approval | Final confirmation action performed by the admin role | Different from "confirmation" |
```
