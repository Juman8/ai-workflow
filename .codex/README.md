# Development Flow Utilizing AI in All Processes

## Table of Contents

- [Selecting the Project Type](#selecting-the-project-type)
- [Selecting the Development Method](#selecting-the-development-method)
- [BMAD + Superpowers: Macro-Micro Workflow](#bmad--superpowers-macro-micro-workflow)
- [Summary of All Processes](#summary-of-all-processes)
  - [Waterfall](#waterfall)
  - [Agile (Scrum)](#agile-scrum)
- [Guide to Selecting Documents by Scale](#guide-to-selecting-documents-by-scale)
  - [Scale Guidelines](#scale-guidelines)
  - [Recommended Document Sets by Scale](#recommended-document-sets-by-scale)
  - [Omission/Substitution Patterns](#omissionsubstitution-patterns)
  - [Items that can be Omitted (Use the document but reduce content)](#items-that-can-be-omitted-use-the-document-but-reduce-content)
- [Preparation and Mindset for Using AI More Efficiently](#preparation-and-mindset-for-using-ai-more-efficiently)
  - [How to Perceive AI](#how-to-perceive-ai)
  - [Mindset](#mindset)
  - [Preparation and Techniques for Saving Tokens](#preparation-and-techniques-for-saving-tokens)
  - [Token-Saving Tools](#token-saving-tools)
  - [Priority Summary](#priority-summary)
  - [Daily Habits](#daily-habits)
  - [Saving Tokens by Combining Multiple AI Tools](#saving-tokens-by-combining-multiple-ai-tools)
  - [Mapping of Tools to Deliverables/Code](#mapping-of-tools-to-deliverablescode)
- [Phase 1: Requirements Definition](#phase-1-requirements-definition)
- [Phase 1.5: Effort Estimation](#phase-15-effort-estimation)
- [Phase 2: Design](#phase-2-design)
- [Phase 3: AI Development Preparation](#phase-3-ai-development-preparation)
- [Phase 4: AI Development (Code Generation)](#phase-4-ai-development-code-generation)
- [Maintaining Specifications (When Modifying Code First)](#maintaining-specifications-when-modifying-code-first)
- [Phase 5: Testing](#phase-5-testing)
- [Phase 6: Deliverable Generation](#phase-6-deliverable-generation)
- [Agile Development Flow](#agile-development-flow)
  - [Sprint 0 (1-2 weeks): Kickoff](#sprint-0-1-2-weeks-kickoff)
  - [Sprint N (2 weeks each): Iterative Development](#sprint-n-2-weeks-each-iterative-development)
  - [Pre-Release (1 week): Final Confirmation & Delivery](#pre-release-1-week-final-confirmation--delivery)
- [Template List](#template-list)
- [Checklist](#checklist)

---

## Selecting the Project Type

First, confirm the project type and development method. The combination will change the instructions given to the AI and the required deliverables.

| Type | Definition | Examples |
|---|---|---|
| **New Project** | Build a system from scratch | New web application, new development of a core system |
| **Existing Project** | Add features or make modifications to a running system | Additional feature development, refactoring, bug fixes |

## Selecting the Development Method

| Method | Approach | Suitable Projects |
|---|---|---|
| **Waterfall** | Proceed through Requirements Definition → Design → Development → Testing → Delivery in sequential phases. | Requirements are fixed; government projects; large SIer projects. |
| **Agile (Scrum)** | Iterate through Design to Testing in 2-week sprints. | Requirements are likely to change; small to medium scale; startups; speed-focused projects. |

> **For small to medium projects and Agile:** Please refer to the "[Agile Development Flow](#agile-development-flow)" section later. Details of each Waterfall phase will follow.

---

## BMAD + Superpowers: Macro-Micro Workflow

> **BMAD** = Breakthrough Method of Agile AI-Driven Development.
> BMAD handles the **macro layer** (what to build and why). Superpowers skills handle the **micro layer** (how to build it and how to verify it). The two methods are complementary — BMAD without Superpowers produces specs that sit unused; Superpowers without BMAD produces code without a coherent product vision.

### Division of Responsibilities

| Layer | Tool | Answers | Artifacts |
|---|---|---|---|
| **Macro** | BMAD personas | What / Why / For whom | Project Brief → PRD → Architecture → Epics → Story files |
| **Micro** | Superpowers skills | How / Verify | PRP → harness execution → PR |

### BMAD Personas → Superpowers Skills Mapping

| Phase | BMAD Persona | Superpowers Skill |
|---|---|---|
| Discovery | Analyst | `/brainstorming` |
| Requirements | PM + Analyst | `/writing-plans`, `prp-plan` |
| Architecture | Architect | `/writing-plans`, `/requesting-code-review` |
| Story Breakdown | Tech Lead + PM | `/writing-plans` |
| Implementation | Developer | `prp-implement`, `/executing-plans`, `/test-driven-development` |
| Parallel tasks | Developer × N | `/dispatching-parallel-agents`, `/using-git-worktrees` |
| Review & Ship | QA + Tech Lead | `/verification-before-completion`, `prp-pr`, `/finishing-a-development-branch` |

### Artifact Traceability Chain

```
[Project Brief]          tpl/project-brief_en.md   ← BMAD entry point; vision & epic overview
    │  produced by Analyst + PM personas
    ▼
[PRD]                    tpl/prd_en.md              ← Epic table (§5.3) bridges Brief → Stories
    │  produced by PM persona
    ▼
[Architecture]           tpl/architecture_en.md     ← BMAD Architect Checklist (§10) + ADR log (§11)
    │  produced by Architect persona
    ▼
[Story Files]            tpl/story_en.md            ← stories/EP-XX-US-YYY-*.md per story
    │  story_id links back to Epic in PRD
    ▼
[PRP]                    tpl/prp_en.md              ← story_id: EP-01-US-001 in YAML front-matter
    │  run by harness
    ▼
[Harness execution]      harness/harness-runner.sh  ← Generator → Evaluator loop, min_score gate
    │
    ▼
[PR / merge]             `prp-pr` + `prp-commit`
```

### How to Start a BMAD + Superpowers Project

1. **Create the Project Brief** (`tpl/project-brief_en.md`) with the Analyst persona — fill the problem, vision, and Epic overview.
2. **Generate the PRD** using the PM persona — populate §5.3 Epics & Story Map.
3. **Draft Architecture** using the Architect persona — complete the BMAD Architect Checklist (§10) before any story is written.
4. **Break down Stories** using the Tech Lead — create one `stories/EP-XX-US-YYY-*.md` per story using `tpl/story_en.md`.
5. **Create PRPs** using `prp-plan` skill — set `story_id` in YAML to link back to the story file.
6. **Execute** via `/executing-plans` or `prp-implement` skill — harness runs generator → evaluator loop.
7. **Ship** with `prp-pr` → `/finishing-a-development-branch` after QA persona review.

> **When to skip BMAD:** Single-developer projects under 3 weeks, spike/prototypes, or pure bug-fix sprints. Use PRP + Superpowers skills directly in these cases.

---

## Summary of All Processes

### Waterfall

| Phase | New Project | Existing Project |
|---|---|---|
| 1. Requirements Definition | Create Requirements Definition Document, SRS, and Business Flow diagrams from scratch. | Define only change requirements (diffs) and identify the scope of impact. |
| 1.5. Effort Estimation | Estimate for the full scope, covering all features. | Estimate based on changed parts plus the risk of regression. |
| 2. Design | Design the entire architecture, DB, API, and screens. | Design only the changed parts (differential design). |
| 3. Development Preparation | Create CLAUDE.md from scratch based on design documents. | Generate and update CLAUDE.md by having the AI read the existing code. |
| 4. Development | Generate code from scratch. | Instruct the AI to add/modify after it understands the existing code. |
| 5. Testing | Create a new test suite for all features. | Focus on testing new features and regression testing. |
| 6. Delivery | Create all documents from scratch. | Update existing documents with the differences. |

### Agile (Scrum)

| Phase | Content | Key Deliverables |
|---|---|---|
| Sprint 0 (1-2 weeks) | High-level requirements, technology selection, environment setup, backlog creation. | Requirements Definition (high-level), Basic Design, Backlog. |
| Sprint 1-N (2 weeks each) | Iterate through Planning → Development → Review → Retrospective. | Sprint Backlog, working software, retrospective records. |
| Pre-Release (1 week) | Integration testing, document preparation, acceptance. | Test Result Report, Manuals, Acceptance Confirmation. |

> The human's role is to focus on review, decision-making, and customer interaction, while the AI generates documents and code.

---

## Guide to Selecting Documents by Scale

> You don't need to create every template every time. Omit and integrate them according to the project scale.

### Scale Guidelines

| Scale | Team | Duration |
|---|---|---|
| **Small** | 3 people or less | Within 3 months |
| **Medium** | 5 people or less | Within 6 months |
| **Large** | 6 people or more | Over 6 months |

### Recommended Document Sets by Scale

| Document | Small | Medium | Large |
|---|:---:|:---:|:---:|
| **BMAD Project Brief** | × | △ | ○ |
| **BMAD Story Files** (stories/*.md) | × | △ | ○ |
| Requirements Definition (PRD) Ch. 1-4 | ○ | ○ | ○ |
| Requirements Definition (PRD) Ch. 5-9 | △ | ○ | ○ |
| Functional/Non-Functional Req. (SRS) Non-functional/Security | ○ | ○ | ○ |
| Functional/Non-Functional Req. (SRS) Functional Details | △ | ○ | ○ |
| Business Flow Diagram | △ | ○ | ○ |
| Migration Requirements | Migration only | Migration only | Migration only |
| Operations Requirements | △ | ○ | ○ |
| Basic Design Document | ○ | ○ | ○ |
| DB Design Document | ○ | ○ | ○ |
| API Specification | △ | ○ | ○ |
| Screen Design Document | △ | ○ | ○ |
| Architecture Decision Record (ADR) | × | △ | ○ |
| CLAUDE.md | ○ | ○ | ○ |
| AI Coding Standards | △ | ○ | ○ |
| AI Implementation Instruction (PRP) | × | ○ | ○ |
| Test Plan | × | △ | ○ |
| Test Specification | × | △ | ○ |
| Test Result Report | ○ | ○ | ○ |
| Bug Tracking Sheet | ○ | ○ | ○ |
| User Manual | △ | ○ | ○ |
| Administrator Manual | × | △ | ○ |
| Release Notes | ○ | ○ | ○ |
| Environment Setup Guide | × | △ | ○ |
| Acceptance Confirmation | ○ | ○ | ○ |

> ○: Create △: Create as needed ×: Can be omitted

### Omission/Substitution Patterns

| Omissible Document | Alternative |
|---|---|
| Test Plan / Test Specification | Acceptance criteria in the sprint backlog + DoD |
| AI Implementation Instruction (PRP) | Write task instructions directly in CLAUDE.md |
| Administrator Manual | If admins are developers or for internal tools, use README.md |
| Environment Setup Guide | Describe in the repository's README.md |
| Architecture Decision Record (ADR) | Add a brief reason in the tech stack section of the basic design doc |
| Business Flow Diagram | Use scope description in PRD + use case diagrams |

### Items that can be Omitted (Use the document but reduce content)

| Document | Omissible Section/Item | Condition |
|---|---|---|
| PRD | Chapter 7 "Glossary" | Only industry-standard terms are used |
| PRD | Chapter 9 "Approvals" | For internal projects or when verbal confirmation is sufficient |
| SRS | 2.5 "Scalability", 2.6 "Upward Compatibility" | Standalone system with no external integrations |
| SRS | 2.7 "Continuity" | When relying on standard cloud features |
| SRS | Permission Matrix | When all users have the same permissions (only one role) |
| Testing | ST, UAT | When sprint reviews in Agile serve as a substitute |

---

## Preparation and Mindset for Using AI More Efficiently

### How to Perceive AI

> **Treat it as "a talented engineer on their first day."**

The AI can write code, generate documents, and knows patterns. However, it knows nothing about the project's background, customer circumstances, or implicit rules. Therefore, the premise is to **provide the necessary context every time**.

| What AI is good at | What AI is bad at (Situations to avoid using it) | What humans should own |
|---|---|---|
| Generating first drafts of documents (PRD, design docs, test specs) | Deciding on brand/design direction (concept creation) | The "why" behind the requirements (customer intent, business context) |
| Generating, refactoring, and detecting bugs in code | Negotiating with customers/stakeholders, relationship building | What should be built (priority and scope decisions) |
| Comprehensive test case generation | Final legal and contractual judgments (contract review, legal interpretation) | Determining quality standards and risk tolerance |
| Creating standardized documents, meeting minutes, release notes | Making organization-specific political judgments and decisions | Final review and accountability to the customer |

> **Reality in Practice:** An MIT study found that **95% of pilots fail to produce measurable financial impact**. McKinsey reports that **70% of corporate adoptions fail to meet expected outcomes**. The procedures in this guide (maintaining CLAUDE.md, managing PRPs, quantitative measurement) are at the core of the design that makes the difference.

### Mindset

#### Utilizing Time While the AI is Working (Doing other tasks while the AI works)

Once you give a task to the AI, **do other productive work while it's running**. Watching the AI's output is a waste of time and creates context-switching costs.

**Basic Flow:**

```
Give PRP (Task Instruction Sheet) to start the AI
    │
    ▼
While AI is running → Turn off notifications and do other work
    │
    ▼
Come back and review after the AI is finished
```

**Examples of tasks you can do while the AI is running:**

| Category | Specific Task |
|---|---|
| Prepare for the next task | Create the next PRP, organize the backlog |
| Documentation | Review specifications/design documents, write meeting minutes |
| Team Communication | Respond to code review comments, handle customer correspondence |
| Design/Thinking | Consider the architecture, plan the next sprint |
| Lightweight Coding | Fix small bugs in other files (within a scope that doesn't require an Agent) |

> **Turn off notifications.** Watching the AI's progress in real-time causes context switching and breaks your concentration. Configure it to notify you when it's done, and focus entirely on other work until then.

**Relationship with the Single-Task Principle:**
- NG: Launching Agents in multiple terminals simultaneously (parallel Agents)
- OK: A human doing other work while one Agent is running (human time utilization)

---

#### Single-Task Principle (One person, one terminal, focus on one task)

The misconception that "running Agents in parallel is faster" is common, but **an engineer running Agents in multiple terminals at the same time is prohibited**.

Reasons:
- You lose track of which Agent is changing what.
- Code conflicts and merge conflicts occur frequently.
- Reviews can't keep up, leading to lower quality.

**Team's Principle of Responsibility Separation:**

| Role | Scope of Work |
|---|---|
| Infrastructure | `project-infra/` only |
| API | `project-api/` only |
| Frontend | `project-web/` only |
| Mobile | `project-app/` only |

It's OK for different roles to work in parallel during the same time frame (inter-team parallelism). What's NG is **one person running multiple Agents at the same time** (intra-person parallelism).

| Don'ts | Do's |
|---|---|
| Launch Claude Code in multiple terminals at once | Complete one task in one terminal before moving to the next |
| One person handles API and FE implementation simultaneously | Fix your area of responsibility and complete tasks serially |
| Start the next implementation with another Agent during a review | Start the next task after the review → merge is complete |

---

#### Accepting AI Output as a "Draft"

The AI **produces an 80% complete draft in seconds**. The human **completes the remaining 20% through judgment and correction**.

- It's faster to "get a draft and fix it yourself" than to "repeatedly adjust the prompt for a perfect output."
- Don't skip reviewing the generated output. The AI can write incorrect things with great confidence.
- Have the perspective of finding and utilizing the good parts (it's a loss to reject everything and start from scratch).

#### The "Why" is Owned by Humans

You can delegate "What to make" and "How to make it" to the AI. **Humans must retain "Why we are making it."**

If you delegate everything to the AI without owning the "Why," you'll get something that works correctly but doesn't solve the customer's problem. Do not let go of requirements definition, scope decisions, and priority setting as human tasks.

#### Managing Prompts as Files (Knowledge Accumulation for the Team)

When using AI as a team, **managing prompts as files instead of entering them directly each time** helps accumulate knowledge.

- The history of improvements is saved by modifying and updating prompt files.
- "How should I instruct for this task?" becomes shared team knowledge.
- New members can quickly become effective by referencing existing files.
- The PRP (AI Implementation Instruction) is a practical example of this idea.

| Don'ts | Do's |
|---|---|
| Write prompts directly in the chat every time | Place prompt files in `prp/` or `.github/` |
| Good prompts remain only in individual memory | Update files to share and improve as a team |

> **Reference (NTT DATA Case Study):** They prepared 73 prompt files and 133 documents under `.github/` and strictly enforced a "no direct input, accumulate knowledge through file modification" policy. This resulted in a 100-hour labor reduction compared to the previous year.

---

### Preparation and Techniques for Saving Tokens

#### 1. Enhance CLAUDE.md ★★★ (Top priority, maximum effect)

If CLAUDE.md, the "project instruction manual" for the AI, is outdated, you'll repeat the same preliminary explanations every time. **If you write it once in CLAUDE.md, you can then just say "follow CLAUDE.md."** Since Anthropic caches CLAUDE.md for prompts, the cost drops significantly from the second time onwards.

```
# Information that should be in CLAUDE.md
- Tech stack (language, FW, DB, infrastructure)
- Coding standards (naming, formatting, testing policy)
- Directory structure and roles
- Prohibitions (files not to touch, anti-patterns)
- Frequently used commands (build, test, deploy)
```

**Update CLAUDE.md immediately** when code or design changes.

#### 2. Exclude Unnecessary Files with `.claudeignore` ★★★

Exclude unnecessary files when Claude Code scans the project. Without this, tens of thousands of files in `node_modules` could end up in the context.

```
# .claudeignore (same syntax as .gitignore)
node_modules/
dist/
.next/
*.log
*.lock
coverage/
*.min.js
*.min.css
```

#### 3. Make Instructions Specific and Short ★★★

Vague instructions lead to clarifying questions from the AI, increasing the number of back-and-forth tokens.

| Bad Instruction | Good Instruction |
|---|---|
| "Make a login feature." | "Implement a login feature for Next.js + PostgreSQL. Use email + password for authentication and JWT for session management. Follow the conventions in CLAUDE.md." |
| "Fix the bug." | "The following error log is occurring (paste). Identify the cause and fix it. Minimize the scope of changes." |
| "Write the design document." | "Based on the attached PRD, create a DB design document following the tpl/db-design.md template. Assume about 10 tables." |

Specifying the output format is also effective. Just stating "No explanation needed, return only the code" can significantly reduce tokens.

#### 4. Narrow Down the Files and Scope to Read ★★★

The more you minimize the context given to the AI, the more tokens you can save.

```bash
# Bad: Showing the whole project
"Look at the whole thing and fix it."

# Good: Specifying files and functions
"Just fix the POST /users endpoint in src/api/users.ts."

# Passing only the diff (when updating specs)
git diff HEAD~1 -- src/api/users.ts

# Summarizing logs before passing them
grep "ERROR" server.log | tail -50
```

This is also why this repository uses the `tpl/` templates. It saves the tokens that would be used to make the AI "think about the structure from scratch."

#### 5. Group Related Tasks and Reduce Back-and-Forth ★★

Requesting tasks separately increases the back-and-forth of confirmation and response. Group related tasks into a single instruction.

```
# Bad (3 round trips = 3x the tokens)
"Fix the bug in this code." → "Write tests for it too." → "Update CLAUDE.md as well."

# Good (1 round trip)
"① Fix this bug, ② add tests for the fixed part, ③ update the relevant section of CLAUDE.md. Do it all at once."
```

However, be careful as forcibly grouping unrelated tasks can lower quality.

#### 6. Reuse Structured Output for the Next Step ★★

Reusing structured data once generated by the AI as input for the next instruction eliminates the waste of making it "think from scratch again."

```
Step 1: "List the scope of impact in JSON format."
→ {"files": ["users.ts", "auth.ts"], "tables": ["users"]}

Step 2: "Based on the JSON above, create a change plan." (Don't make it re-search the files)
```

The template-filling format has the same effect. Pass `tpl/` and instruct it to "fill in the [] parts."

#### 7. Break Down Tasks into Smaller Pieces ★★

Giving instructions that are too large at once can lead to ambiguous output and more back-and-forth for corrections.

```
# Bad Example (long output, contains mistakes)
"Design a reservation management system, write the code, and test it."

# Good Example (each step is short and accurate)
Step 1: "Create a DB design document based on the PRD."
Step 2: "Create a list of API endpoints based on the DB design document."
Step 3: "Implement the code according to the API endpoints and CLAUDE.md conventions."
Step 4: "Create a test specification for the implemented code."
```

#### 8. Delegate Independent Tasks to SubAgents ★★

SubAgents start with a fresh context, so they don't consume tokens from the main conversation. Offload heavy review and analysis tasks to SubAgents to make the main session last longer.

```
# Parallel execution without polluting the main context
Agent1 (code-reviewer):    "Code review for src/api/"
Agent2 (security-reviewer): "Security check for the authentication module"
Agent3 (doc-updater):      "Update diffs for the API specification"
```

#### 9. Use Different Models for Different Tasks ★★

| Task | Recommended Model | Reason |
|---|---|---|
| Simple code generation, formatting, document updates | Haiku | Fast, cheap |
| Normal implementation, code review, design doc generation | Sonnet | Balanced |
| Complex architecture decisions, analysis of difficult bugs | Opus | Use only for this |

In Claude Code, you can switch with commands like `/model haiku`.

#### 10. Reset/Compress the Conversation ★

Long conversations carry unnecessary context and continue to consume tokens.

| Command | Effect |
|---|---|
| `/clear` | Completely resets the conversation history. Use when the task changes. |
| `/compact` | Summarizes and compresses the conversation while continuing. Use when you want to save tokens while maintaining context. |

---

### Token-Saving Tools

| Tool | Purpose | How it saves | Adoption Cost |
|---|---|---|---|
| **Serena** | Searching and refactoring large codebases | Retrieves by symbol (no need for the whole file) | Medium (separate installation) |
| **Context7** | Referencing the latest docs for libraries/FWs | Retrieves only relevant parts (no need to paste the full text) | Low (already configured) |
| `/clear` `/compact` | Resetting/compressing long sessions | Deletes/compresses accumulated context | None (built-in) |

**How to introduce Serena** (for large projects with many files):

```bash
uv tool install -p 3.13 serena-agent@latest --prerelease=allow
serena init
# → Can be used from Claude Code by registering it as an MCP server in ~/.claude.json
```

**How to use Context7** (already configured, ready to use):

```
"Tell me how to use server actions in Next.js 15 (use context7)"
```

---

### Priority Summary

| Priority | Measure | Cost |
|---|---|---|
| ★★★ | Enhance CLAUDE.md to eliminate preliminary explanations | Low |
| ★★★ | Exclude unnecessary files with `.claudeignore` | Low |
| ★★★ | Narrow down and pass specific files/scopes | Low |
| ★★ | Specify output format to omit redundant explanations | Low |
| ★★ | Group related tasks to reduce back-and-forth | Low |
| ★★ | Delegate independent tasks to SubAgents | Low |
| ★★ | Use different models for different tasks | Low |
| ★ | Get pinpoint documentation with Context7 | Low (configured) |
| ★ | Manage sessions with `/clear` `/compact` | Low |
| ★ | Symbol-level code operations with Serena | Medium (install required) |

---

### Daily Habits

```
[Before Coding]
- Open CLAUDE.md and check if it's up-to-date.
- Check if .claudeignore is configured.
- Summarize the acceptance criteria for today's task in one sentence before giving it to the AI.
- Narrow down and specify the relevant files and scope.

[After Coding]
- Review the generated code (variable names, error handling, security).
- Commit only after confirming that tests pass (utilize the /commit skill).
- If specifications change, update CLAUDE.md immediately.
- When the task changes, reset the session with /clear.

[At the End of the Sprint]
- Have the AI regenerate the diffs for the API specification and DB design document by passing it the git diff.
- Update the bug tracking sheet and release notes with the AI.
- Have the AI draft the backlog for the next sprint for the team to review.
```

---

### Saving Tokens by Combining Multiple AI Tools

Relying solely on Claude Code can be expensive. By using different tools based on their strengths, you can significantly reduce costs.

#### Characteristics of Each Tool

| Tool | Strength | Pricing Model | Free Tier |
|---|---|---|---|
| **Claude Code** | Complex implementation, spec generation, long-text understanding | Pay-per-token | None |
| **Claude Design** | UI generation from text, interactive prototypes, pitch decks | Pro/Max/Team/Enterprise | None (Research Preview) |
| **Cursor** | IDE integration, inline completion, chat | Monthly subscription ($20+) | 2-week trial |
| **GitHub Copilot** | Real-time completion, PR summaries | Monthly subscription ($10+) | Free for students |
| **Gemini Flash** | Very large context (1M tokens) | Pay-per-use + free tier | Essentially free |
| **ChatGPT** | General writing, explanations, translation | Monthly subscription or pay-per-use | Free tier for GPT-4o |

#### Optimal Tool for Each Task

```
Heavy (complex, requires large context)
  └→ Claude Code Sonnet / Opus
       ・Architecture design, spec generation, complex bug fixes

Medium (large context but simple judgment)
  └→ Gemini Flash (Free)
       ・Reading/summarizing huge files, analyzing large logs
       ・Understanding the entire codebase to create a summary for CLAUDE.md

Light (repetitive, boilerplate, completion)
  └→ Cursor / GitHub Copilot (Subscription)
       ・Inline completion, variable names, comments, test templates

Writing (Japanese/English documents)
  └→ ChatGPT / Gemini Free Tier
       ・Meeting minutes, manuals, release notes, translation

UI/Screen Design (Prototypes, wireframes, materials)
  └→ Claude Design (Pro/Max/Team/Enterprise)
       ・UI generation from text, interactive prototypes
       ・Pitch decks, marketing materials
       ・Can export to Canva / PDF / HTML
```

#### Combination Patterns

**Pattern 1: Create an "unlimited use" area with subscription tools**

Delegate daily completions to Cursor/Copilot (subscription) and limit Claude Code's use to only tasks that Cursor can't solve.

**Pattern 2: Process large contexts with Gemini**

```bash
# Summarize huge logs or the entire legacy codebase with Gemini (free)
→ Paste the generated summary into CLAUDE.md
→ From then on, Claude only needs to read CLAUDE.md (runs with fewer tokens)
```

**Pattern 3: Draft with a cheap model → Finalize with an expensive model**

```
Step 1: Gemini Flash / ChatGPT (Free/Cheap)
       "Give me three design proposals for this API." → Generate rough options at low cost

Step 2: Claude Sonnet (Paid)
       "Implement based on proposal #2 above. Follow CLAUDE.md."
       → Implement only the confirmed plan with a high-quality model
```

#### Tool Selection Flowchart

```
When a task comes in

  ↓ Inline completion, small fix?
  → YES → Cursor / Copilot (subscription, don't worry about tokens)

  ↓ NO Japanese document, translation, writing?
  → YES → ChatGPT Free Tier / Gemini Free Tier

  ↓ NO Analysis of huge files or large logs?
  → YES → Gemini Flash (Free, 1M tokens)

  ↓ NO Complex implementation, design, spec generation?
  → YES → Claude Code Sonnet

  ↓ NO Deep architectural judgment, difficult bug?
  → YES → Claude Code Opus (only for this)
```

---

### Mapping of Tools to Deliverables/Code

#### Specifications & Documents

| Deliverable | Recommended Tool | Reason |
|---|---|---|
| Requirements Definition (PRD) | ChatGPT / Gemini Free | Converting interview notes to text is standard writing. |
| Functional/Non-functional Req. (SRS) | Claude Sonnet | Requires checking consistency of technical requirements. |
| Business Flow Diagram (Text) | ChatGPT / Gemini Free | Converting bullet points to a flow is a standard task. |
| Basic Design (Architecture) | Claude Sonnet / Opus | Requires technical judgment and consistency. |
| DB Design Document | Claude Sonnet | Requires consistency with code and normalization judgment. |
| API Specification | Claude Sonnet | Reverse-engineering from code and consistency checks needed. |
| Screen Design Document | ChatGPT / Gemini Free | Documenting screen items is a standard writing task. |
| Figma Design (UI) | **Claude Design** / Figma AI | UI generation from text, creating interactive prototypes. |
| ADR (Tech Selection Record) | Claude Sonnet / Opus | Requires deep technical judgment. |
| CLAUDE.md | Claude Sonnet | Requires understanding the codebase and its structure. |
| AI Coding Standards | Claude Sonnet | Organizing project-specific rules. |
| AI Implementation Instruction (PRP) | Claude Sonnet | Task decomposition and dependency organization. |
| Test Plan | Claude Sonnet | Requires checking consistency with specifications. |
| Test Specification | Claude Sonnet / Copilot | Many parts can be auto-generated from code. |
| Test Result Report | ChatGPT / Gemini Free | Converting numbers/results to text is standard writing. |
| Bug Tracking Sheet | Gemini Flash (Free) | Bulk analysis of large logs and errors. |
| User Manual | ChatGPT / Gemini Free | Standard Japanese writing. |
| Administrator Manual | ChatGPT / Gemini Free | Standard Japanese writing. |
| Release Notes | ChatGPT / Gemini Free | Converting git log to text is a standard task. |
| Environment Setup Guide | Claude Sonnet | Accuracy of commands and settings is required. |
| Migration Requirements | Claude Sonnet | Requires data consistency and risk judgment. |
| Operations Requirements | ChatGPT / Gemini Free | Standard requirements writing. |
| Meeting Minutes | ChatGPT / Gemini Free | Converting notes to text is standard writing. |
| Acceptance Confirmation | ChatGPT / Gemini Free | Filling out a standard format. |
| Sprint Backlog | ChatGPT / Claude Sonnet | Simple organization with ChatGPT, complex decomposition with Claude. |
| Retrospective | ChatGPT / Gemini Free | Standard retrospective documentation. |

#### Code & Development Tasks

| Task | Recommended Tool | Reason |
|---|---|---|
| Inline completion (rest of a function) | Cursor / Copilot | Real-time completion, unlimited use with subscription. |
| Add variable names, comments | Cursor / Copilot | Lightweight task, completion is sufficient. |
| Test code template | Cursor / Copilot | The pattern is fixed. |
| Simple refactoring | Cursor / Claude Haiku | No logic change, just formatting. |
| Bug fix (cause is clear) | Claude Sonnet | Pass the specific part to be fixed. |
| Bug fix (cause is unknown) | Gemini Flash → Claude Sonnet | Analyze large logs with Gemini → Fix with Claude. |
| New feature implementation | Claude Sonnet | Implement by passing CLAUDE.md and specifications. |
| Architecture change | Claude Opus | Requires judgment of deep impact. |
| Code review | Claude Sonnet (code-reviewer) | Overall judgment of security and quality. |
| Security review | Claude Sonnet (security-reviewer) | Specialized judgment of OWASP and vulnerabilities. |
| Large-scale refactoring | Serena + Claude Sonnet | Symbol-level operation with Serena, judgment with Claude. |
| Grasping the entire codebase | Gemini Flash (Free) | Read all files at once with 1M tokens. |
| Library research, usage | Context7 | Get the latest documentation pinpointed. |
| Translating English comments, README | ChatGPT / Gemini Free | Translation and writing are standard tasks. |
| Commit message generation | Cursor / Copilot (/commit) | Lightweight, processed within subscription. |
| PR description generation | ChatGPT / Claude Sonnet | ChatGPT for simple things, Claude for complex changes. |
| Resolving build errors | Claude Sonnet (build-error-resolver) | Requires matching error logs with code. |

#### Decision Criteria

```
When free/subscription tools are sufficient:
  ├─ Input is small (within a few hundred lines)
  ├─ Standard task (translation, documentation, completion)
  └─ No code understanding or consistency check required

When Claude (paid, pay-per-use) is necessary:
  ├─ Understanding the codebase is a prerequisite
  ├─ Consistency check of specs, design, and code
  └─ Specialized judgment of security and quality
```

---

## Phase 1: Requirements Definition

### New Project

```
Customer Hearing (Human)
    │
    ▼
Pass hearing notes to AI
"Create a PRD from the following hearing content:
 - We want to systematize our rental business's reservation management.
 - Currently managed in Excel.
 - Number of users is 10 employees."
    │
    ▼
What AI generates:
  ├── PRD (Business goals, scope, user stories, glossary)
  ├── SRS (Functional, non-functional, security requirements)
  ├── Business Flow Diagram As-Is → To-Be (Mermaid)
  ├── Feature List (with MoSCoW priority)
  └── Operations Requirements Definition (monitoring, backup, maintenance)
    │
    ▼
Have AI ask for missing perspectives
"Review this PRD and list any missing perspectives
 in a question list format."
    │
    ▼
Human gets additional confirmation from the customer → Sign-off
```

### Existing Project

```
Hearing for change requirements (Human)
    │
    ▼
Pass existing specifications + hearing notes to AI
"Reference the existing system's specifications and
 organize the differences with the new requirements.
 Also, list existing features that will be affected."
    │
    ▼
What AI generates:
  ├── Change Requirements Definition (diffs only)
  ├── List of affected areas (impact on existing features)
  ├── Business Flow Diagram (To-Be for changed parts only)
  ├── List of added/changed features
  ├── Migration Requirements Definition (data migration, cutover procedure) *If migration is involved
  └── Operations Requirements Definition (monitoring, backup, maintenance)
    │
    ▼
Human reviews the scope of impact → Customer confirmation → Sign-off
```

**Comparison of AI Instruction Patterns**

| Step | New Project | Existing Project |
|---|---|---|
| 1. Organize Req. | "Create a PRD from the hearing notes." | "Summarize the differences with existing specs into a change requirements doc." |
| 2. Deep Dive | "List questions for any missing requirements." | "List existing features affected by this change." |
| 3. Flow | "Create As-Is/To-Be business flows in Mermaid." | "Update only the To-Be flow for the changed parts." |
| 4. Prioritize | "Prioritize the feature list using the MoSCoW method." | "Order the changed features by release priority." |

> **Point (Existing):** Prevent oversights in impact assessment by passing existing specifications, design documents, and code to the AI. Have it clarify not only "what changes" but also "what doesn't change."

**Deliverables**

| New Project | Existing Project |
|---|---|
| PRD / SRS / Business Flow Diagram / Feature List (MoSCoW) / Operations Req. | Change Req. Doc / Impact List / Changed Feature List / Migration Req. (if migrating) / Operations Req. |

---

## Phase 1.5: Effort Estimation

### New Project

```
Feature List
    │
    ▼
Instruction to AI
"Estimate the development effort for all features:
 - Developers: 1 frontend, 1 backend
 - Tech stack: React + Node.js + PostgreSQL"
    │
    ▼
What AI generates:
  ├── Effort table per feature (breakdown of design, implementation, testing)
  ├── Total estimate including buffer
  ├── Optimistic, standard, pessimistic scenarios
  └── List of risks (factors that could increase effort)
    │
    ▼
Additional instruction to AI
"Create a schedule for 2-week sprints."
    └── Sprint plan table (in MoSCoW priority order)
```

### Existing Project

```
Changed Feature List + Scale of existing codebase
    │
    ▼
Instruction to AI
"Estimate the effort for the following changes.
 Include effort for impact analysis of existing code
 and regression testing."
    │
    ▼
What AI generates:
  ├── Effort table for each changed part
  ├── Impact analysis effort (reading existing code)
  ├── Regression testing effort
  └── List of risks (focusing on risks to existing functionality)
    │
    ▼
Human adjusts based on experience → Present to customer
```

**Differences in Estimation Perspectives: New vs. Existing**

| Estimation Aspect | New | Existing |
|---|---|---|
| Scope | All features | Changed parts only |
| Additional effort needed | Environment setup, initial design | Impact analysis, regression testing |
| Main source of risk | Requirement uncertainty, tech selection | Complexity of existing code, side effects |
| Buffer estimate | 20-30% | 30-40% (depends on quality of existing code) |

> **Point:** For existing projects, always include "analysis effort and regression testing effort" in the estimate, not just "change effort."

---

## Phase 2: Design

### New Project

```
PRD / SRS
    │
    ▼
Instruction to AI (Architecture, DB, API)
"Based on this PRD, create the following:
 - System architecture diagram, ER diagram, table definitions, API specification."
    │
    ▼
What AI generates:
  ├── Software Architecture Document
  ├── DB Design Document (ER diagram, table definitions)
  ├── API Specification (OpenAPI / Swagger)
  └── ADR (Rationale for technology choices)
    │
    ▼
Create screen designs (Designer or AI)
"Based on the screen list and transition diagram in the design document, create screen designs."

  ┌─ Option A: Claude Design (Pro/Max/Team/Enterprise)
  │    "Generate wireframes and an interactive prototype based on the design document."
  │    → Export to Canva / HTML, then import into Figma.
  │
  └─ Option B: Figma (Designer creates directly)
       → If customer approval and brand precision are important.
    │
    ▼
What AI generates:
  └── Screen Design Document (Design URL + input specs, validation, error definitions)
```

### Existing Project

```
Change Requirements Doc + Existing Design Docs
    │
    ▼
Instruction to AI (Architecture, DB, API diffs)
"Reference the existing design documents and create a differential design document for the changed parts only."
    │
    ▼
What AI generates:
  ├── DB change definitions (new tables, column changes, migration strategy)
  └── API change specifications (new endpoints, modified specs)
    │
    ▼
Update diff designs in Figma (Designer or AI)
"Update only the changed screens in the existing Figma file."
    │
    ▼
What AI generates:
  └── Screen Design Document (Figma URL of changed screens + diffs in behavior specs)
```

**Differences in Design Document Scope**

| Design Document | New | Existing |
|---|---|---|
| Architecture | Create the entire thing from scratch | Append/update only the changed parts |
| DB Design | ER diagram, all table definitions | New tables, changed columns, migration strategy |
| API Specification | Define all endpoints | Only new/changed endpoints |
| Screen Design | Create UI for all screens with Claude Design / Figma | Update UI for changed screens only with Claude Design / Figma |
| Screen Design Doc | Design URLs + behavior specs for all screens | Design URLs for changed screens + diffs in behavior specs |
| ADR | Record technology choices from scratch | Append to existing ADR (record reasons for changes) |

> **Role division between Screen Design Tool and Screen Design Document:** Claude Design / Figma handles the UI and visuals. The Screen Design Document handles what the design tool can't express alone: input specifications, validation, error messages, and state definitions.

> **Choosing between Claude Design and Figma:** Use Figma if customer approval and brand precision are important. Use Claude Design for speed, internal team review, and prototype validation. Claude Design can export to Canva / HTML and be imported into Figma via a plugin, allowing for combined use. Requires a Pro/Max/Team/Enterprise plan (Research Preview).

**Deliverables**

| New Project | Existing Project |
|---|---|
| System Architecture Diagram / Figma Design / Screen Design Doc / DB Design Doc / API Spec | Figma Diffs / Screen Design Doc (diffs) / DB Change Definitions / API Change Specs |

---

## Phase 3: AI Development Preparation

### New Project

```
Design Documents (Deliverables from Phase 2)
    │
    ▼
Instruction to AI
"Based on these design documents, create CLAUDE.md and
 AI Coding Standards."
    │
    ▼
What AI generates:
  ├── CLAUDE.md (Overall project instruction manual for the AI)
  ├── AI Coding Standards (Coding conventions)
  └── List of PRPs (Templates for task-specific AI instructions)
```

### Existing Project

```
Existing Codebase + Differential Design Docs
    │
    ▼
Instruction to AI (Step 1: Understand existing code)
"Read the existing code and analyze the current tech stack,
 directory structure, and coding patterns to generate CLAUDE.md."
    │
    ▼
What AI analyzes and generates:
  ├── CLAUDE.md reverse-engineered from existing code
  └── Summary of existing coding patterns
    │
    ▼
Instruction to AI (Step 2: Create PRP for changes)
"Create a PRP for this change task.
 Include an implementation approach that matches the existing implementation patterns."
    │
    ▼
  └── Task-specific PRP for changes (conforming to existing patterns)
```

**Differences in Development Preparation**

| Item | New | Existing |
|---|---|---|
| CLAUDE.md | Create from scratch from design docs | Reverse-engineer by having the AI read existing code |
| Coding Standards | Define from scratch | Document by having the AI analyze existing code patterns |
| PRP | Create for all tasks | Create only for change tasks, matching existing patterns |

**Deliverables:** CLAUDE.md / AI Coding Standards / PRP List (internal, not public)

### Claude Code Configuration (Skills & SubAgents)

Along with creating CLAUDE.md, configure Claude Code's Skills and SubAgents according to the project scale.

#### AGENTS.md (Record of AI Behavior Improvements)

Separate from CLAUDE.md, keep an **`AGENTS.md`** file in the repository to record and improve the AI's bad behaviors.

```
# Role division for AGENTS.md

CLAUDE.md   → Describes the project's overall technology, conventions, and structure (information that doesn't change).
AGENTS.md   → Records the AI's recurring bad behaviors and instructions for improvement (nurtured through operation).
```

**Example content for AGENTS.md:**

```markdown
# AGENTS.md

## Don'ts

- Do not ignore existing error handling patterns and implement your own.
- Do not commit code without tests.
- Do not use `any` to escape type definitions.
- Do not output unnecessary comments or progress declarations.

## Recurring Issues and Countermeasures

| Issue | Situation | Countermeasure |
|---|---|---|
| Import paths become relative | When generating components | Always use aliases (@/). |
| Leaves `console.log` | After debugging | Always remove before committing. |
```

Add notes about the AI's behavior that you notice during the sprint. A workflow of smaller, more frequent updates suits AGENTS.md better than CLAUDE.md.

#### Recommended Settings by Scale/Purpose

| | Small | Medium | Large |
|---|:---:|:---:|:---:|
| **Skills (Slash Commands)** | | | |
| `/commit` (Auto-generate commit messages) | ★ | ★ | ★ |
| `/review-pr` (Automate PR reviews) | △ | ★ | ★ |
| `/plan` (Create implementation plans for complex features) | × | △ | ★ |
| `/tdd` (Enforce Test-Driven Development) | × | △ | △ |
| **SubAgents (Specialized Agents)** | | | |
| `code-reviewer` (Code review) | ★ | ★ | ★ |
| `security-reviewer` (Security check) | △ | ★ | ★ |
| `build-error-resolver` (Resolve build errors) | △ | △ | ★ |

> ★: Configure △: Configure as needed ×: Not necessary

#### Sequential Loop of Implementation ↔ Review (One-Task Completion Cycle)

Based on the single-task principle, **complete one task with the following loop before moving to the next**.

```
Prepare PRP (Task Instruction Sheet)
    │
    ▼
Implement with Claude Code (1 terminal)
    │
    ▼
Get a review from the code-reviewer SubAgent
    │
    ▼
Fix the pointed-out issues (re-implement)
    │
    ▼
If no issues, commit and merge
    │
    ▼
Move to the next task (reset session with /clear)
```

Do not parallelize this loop. Start the next task after one loop is complete.

#### Solidifying Instructions with Skills

Instructions that tend to be ignored even when written in CLAUDE.md or SubAgent definitions can be given higher priority by defining them as **custom Skills (slash commands)**.

```
Example:
- Do not leave unused code for backward compatibility → Define in a `/cleanup` Skill.
- Have it omit unnecessary progress declarations → Specify in the Skill's system prompt.
- Enforce project-specific naming conventions → Embed a template within the Skill.
```

Place SubAgent definitions in `~/.claude/agents/` and Skill definitions under `.claude/`.
An instruction in a named Skill is more likely to be followed than one buried in a long CLAUDE.md.

#### Usage by Purpose

| Timing | Skill/SubAgent to Use | Purpose |
|---|---|---|
| Before commit | `/commit` | Auto-generate commit message |
| When creating a PR | `/review-pr` | Automate code review |
| After coding (every time) | `code-reviewer` | Check quality, bugs, pattern consistency |
| After implementing auth/personal info handling | `security-reviewer` | Check for security vulnerabilities |
| When a build/type error occurs | `build-error-resolver` | Fix the error with minimal diff |
| When designing complex features | `/plan` | Solidify the implementation plan before generating code |

---

### Claude Code Hooks Configuration

Hooks are a mechanism to enable the workflow of "doing something else while the AI is working."
Every time a file is saved, lint/format runs automatically, a notification is sent when the AI is done, and dangerous commands are blocked before execution.

#### Configuration File Location

```
Project Common: .claude/settings.json   ← Commit to the repository to share
Personal Settings: ~/.claude/settings.json  ← Your personal settings
```

#### Recommended Hooks Configuration (`.claude/settings.json`)

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "cd "$CLAUDE_PROJECT_DIR" && npx prettier --write "$FILE_PATH" 2>/dev/null || true"
          },
          {
            "type": "command",
            "command": "cd "$CLAUDE_PROJECT_DIR" && npx eslint --fix "$FILE_PATH" 2>/dev/null || true"
          }
        ]
      }
    ],
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "echo "$TOOL_INPUT" | grep -qE '(rm -rf|DROP TABLE|force push)' && echo '[BLOCKED] Dangerous command. Please execute manually if necessary.' && exit 2 || exit 0"
          }
        ]
      },
      {
        "matcher": "Write",
        "hooks": [
          {
            "type": "command",
            "command": "node -e "let d='';process.stdin.on('data',c=>d+=c);process.stdin.on('end',()=>{const i=JSON.parse(d);const c=i.tool_input?.content||'';const lines=c.split('
').length;if(lines>800){console.error('[BLOCKED] File exceeds 800 lines ('+lines+' lines). Consider module splitting.');process.exit(2)}console.log(d)})""
          }
        ]
      }
    ],
    "Notification": [
      {
        "matcher": "*",
        "hooks": [
          {
            "type": "command",
            "command": "osascript -e 'display notification "AI has completed the task. Please review." with title "Claude Code"' 2>/dev/null || true"
          }
        ]
      }
    ],
    "Stop": [
      {
        "matcher": "*",
        "hooks": [
          {
            "type": "command",
            "command": "cd "$CLAUDE_PROJECT_DIR" && npx tsc --noEmit 2>&1 | head -20 || echo '[WARNING] Type errors remain'"
          }
        ]
      }
    ]
  }
}
```

#### Hook Types and Their Uses

| Hook | Timing | How it's used in this project |
|---|---|---|
| `PostToolUse` | After saving a file | Auto-run prettier/eslint. Immediately formats code written by the AI. |
| `PreToolUse` | Before executing a command | Block dangerous operations like `rm -rf`, `DROP TABLE`. |
| `Notification` | When the AI is waiting for user input | **Know when to return from other work while the AI is running.** |
| `Stop` | When the AI session ends | Force a type error check with `tsc --noEmit`. |

> **The Notification hook is important**: A notification arrives when the AI has finished its work and is waiting for input.
> This is a mechanism to not miss the timing to come back in a workflow where you "do other work while the AI is running."

#### Exit Code Rules

| Exit Code | Meaning |
|---|---|
| `0` | Success. Continue processing. |
| `2` | **Block**. Feed the error message back to the AI and interrupt processing. |
| Other | Treat as a warning, but continue processing. |

Using exit code `2` makes the AI read the error message and attempt to self-correct.
In the case of a `rm -rf` block, it tells the AI "Please execute manually."

---

## Phase 4: AI Development (Code Generation)

### New Project

```
CLAUDE.md + PRP + Design Docs
    │
    ▼
Instruct AI on a per-task basis (PRP format)
"Create a migration file based on the DB design document."
"Implement the customer list screen in React based on the screen design document."
"Implement the customer search API in Express based on the API specification."
    │
    ▼
What AI generates:
  ├── DB migration file
  ├── Frontend components
  ├── API router, validation
  └── Type definition files
    │
    ▼
Human code review → Merge
```

### Existing Project

```
CLAUDE.md + PRP + Existing Code + Differential Design Docs
    │
    ▼
First, have the AI read the existing code
"Read src/api/customers.ts and related files to
 understand the existing implementation patterns."
    │
    ▼
Instruct the task after it understands
"In accordance with the existing patterns you've grasped,
 add a company name filter to the customer search API.
 Follow the existing validation and error handling patterns."
    │
    ▼
What AI generates:
  ├── Additions/changes to existing code (diffs)
  └── Migration file (for added columns)
    │
    ▼
Human reviews for regressions → Merge
```

**Providing the Verification Mechanism to the AI**

When giving a task to the AI, also telling it "how to verify if it's correct" greatly increases the probability that the AI can self-correct its mistakes.

```
# Bad Example (no verification)
"Implement the customer list API."

# Good Example (with verification mechanism)
"Implement the customer list API.
 After implementation, verify its operation with the following:
 1. Run `npm test src/api/customers.test.ts` and ensure all tests pass.
 2. `curl http://localhost:3000/api/customers` should return a response.
 3. There should be no TypeScript type errors (`tsc --noEmit`)."
```

Types of verification mechanisms:

| Type | Example Instruction |
|---|---|
| Test Execution | "Ensure `npm test <target_file>` passes." |
| Type Check | "Ensure there are no errors from `tsc --noEmit`." |
| Lint | "Ensure there are no errors from `eslint <target_file>`." |
| Manual Check | "Ensure `curl` to the endpoint returns the expected response." |
| E2E | "Ensure `playwright test <target_scenario>` passes." |

> When a verification command is provided, the AI spontaneously enters a loop of "check after I think it's done." If you don't provide it, it assumes it's working and finishes.

**Mapping from Design Docs to AI Code Generation**

| Design Doc | Instruction for New | Instruction for Existing |
|---|---|---|
| Figma + Screen Design Doc | "Implement in React based on the Figma design data and SCR-003 spec sheet." | "Reference existing components and add the diff screen from Figma using existing patterns." |
| DB Design Doc | "Convert this table definition into DDL and a migration." | "Create a migration to add a column to the existing table." |
| API Specification | "Implement the API based on this OpenAPI definition." | "Add the new endpoint to the existing router using existing patterns." |

**Procedure for Utilizing Figma in AI Development**

| Step | Operation | How to pass to AI |
|---|---|---|
| 1. Export Screen | Export Figma frame as PNG/SVG | Attach as an image |
| 2. Share Figma URL | Copy the link to the frame | Include the URL in the prompt |
| 3. Attach Spec Sheet | Paste input items/error definitions from the screen design doc | Attach as Markdown |
| 4. Instruct Implementation | "Implement based on this Figma design and specifications." | - |

> **Point (Existing):** Have the AI read the existing code first before instructing implementation. If you only give it the Figma design, it will generate code that ignores the existing design system and components.

---

## Maintaining Specifications (When Modifying Code First)

> How to handle cases where code is changed directly without updating specifications first, such as for bug fixes or emergency feature fixes.

### For Bug Fixes (Specification does not change)

A bug fix is a case where the system "wasn't working as specified," so **in principle, the specification does not need to be changed**.

| Document Requiring Update | Content |
|---|---|
| Bug Tracking Sheet | Record bug number, cause, fix details, and fix date. |
| Test Specification | Add any missed test cases. |
| Release Notes | Describe the bug fix. |

### For Fixes Involving Specification Changes

The most efficient way is to **have the AI read the git diff and reverse-generate the specifications**.

```
Code fix and merge
    │
    ▼
Instruction to AI
"Read the git diff and update only the relevant parts
 of the following specifications with the changes:
 - API Specification (changed endpoints)
 - Screen Design Document (changed screens)
 - DB Design Document (changed tables/columns)"
    │
    ▼
What AI updates:
  ├── Updates only the changed parts (diffs)
  └── Appends to the document revision history of each specification
```

### Keep CLAUDE.md Updated as Top Priority

In AI development, **as long as CLAUDE.md is up-to-date, the AI will work correctly even if other specifications are slightly outdated**. At a minimum, update CLAUDE.md with every code change.

```
Update with every bug fix/feature fix:
  ├── Changed implementation patterns, prohibitions
  ├── Added constraints, notes
  └── Changed file structure, dependencies
```

### Priority Order for Updates

| Priority | Document | Update Timing |
|---|---|---|
| Highest | CLAUDE.md | Immediately with every fix |
| High | Bug Tracking Sheet, Release Notes | Immediately with every fix |
| Medium | API Spec, DB Design, Screen Design | Batch update at the end of the sprint |
| Low | PRD, SRS | Only when requirements change |

> **Batch Update at Sprint End (Recommended):** Since updating after every single fix is not realistic, an efficient workflow is to have the AI read the git log for the sprint and batch-update the specifications at the same time as the sprint-end retrospective.

---

## Phase 5: Testing

### New Project

```
Test Plan + Implemented Code
    │
    ▼
Instruction to AI
"Implement the test cases from the test specification in Jest."
"Create E2E tests for all features in Playwright."
    │
    ▼
What AI generates:
  ├── Unit test code (for all features)
  ├── Integration test code
  ├── E2E test code (for all major flows)
  └── Test result report
```

### Existing Project

```
Existing Test Suite + Change Specifications
    │
    ▼
Instruction to AI (Step 1: Understand existing tests)
"Read the existing test files to understand the
 test structure."
    │
    ▼
Instruction to AI (Step 2: New + Regression tests)
"Add tests for the newly changed features.
 Also, identify existing tests that might be affected
 and add regression tests."
    │
    ▼
What AI generates:
  ├── Test code for new features
  ├── Regression test code (for affected areas)
  └── Bug tracking sheet (if defects are found)
```

**Focus of Testing Changes**

| Test Type | New | Existing |
|---|---|---|
| Unit Test | Create for all features | Add only for changed functions |
| Integration Test | Create for all APIs | Confirm combination of changed API + existing APIs |
| E2E Test | All major flows | Changed flow + regression confirmation |
| Key check item | Coverage of normal and abnormal cases | Ensuring existing features are not broken |

**Deliverables**

| New Project | Existing Project |
|---|---|
| Test Plan / Test Specification / Test Result Report / Bug Tracking Sheet | Test Spec for changed parts (diff) / Test Result Report / Bug Tracking Sheet |

> **Note (Practical Insight):** The AI generates test cases for what is written in the test specification, but **it rarely auto-completes for boundary conditions and exception cases not mentioned in the spec**. Missed test case extraction is a major cause of bugs slipping through. Make it a habit for humans to review the list of AI-generated test cases and proactively ask, "what about this case?". Be especially careful with frontend code involving a lot of DOM manipulation, as test coverage can easily become incomplete.

---

## Phase 6: Deliverable Generation

### New Project

```
Deliverables from all phases
    │
    ▼
Instruction to AI
"Create a user manual based on the design documents and code."
"Write release notes for the customer in plain language."
    │
    ▼
What AI generates:
  ├── User Manual (for users, first edition)
  ├── Administrator Manual (first edition)
  ├── Release Notes v1.0.0
  └── Environment Setup Guide (first edition)
    │
    ▼
Human prepares the acceptance confirmation → Submit to customer and get signature
  └── Acceptance Confirmation (List of deliverables, acceptance test results, customer signature)
```

### Existing Project

```
Existing Documents + Change Details
    │
    ▼
Instruction to AI
"Reference the existing user manual and update only
 the changed parts."
"Append the latest changes to the release notes."
    │
    ▼
What AI generates:
  ├── User Manual (updated with changes only)
  ├── Administrator Manual (updated with changes only)
  └── Release Notes (version appended)
    │
    ▼
Human prepares the acceptance confirmation → Submit to customer and get signature
  └── Acceptance Confirmation (listing only changed/added deliverables)
```

**Difference in Workload for Deliverables**

| Document | New | Existing |
|---|---|---|
| User Manual | Create for all screens and operations | Append/modify only for changed screens/operations |
| Administrator Manual | Create all procedures from scratch | Append only for changed procedures |
| Release Notes | Create v1.0.0 first edition | Append new version (vX.X.X) |
| Environment Setup Guide | Create all procedures from scratch | Update only if there were changes |
| Acceptance Confirmation | List all deliverables and get customer signature | List only changed/added deliverables and get customer signature |

---

## Agile Development Flow

> For details on the Waterfall phases (Phases 1-6), please refer to the preceding sections. This section shows the flow along the Scrum iteration cycle.

### Sprint 0 (1-2 weeks): Kickoff

```
Customer Hearing (Human)
    │
    ▼
[BMAD optional] Fill Project Brief (tpl/project-brief_en.md)
  Analyst persona: problem statement, product vision, target personas, Epic overview
    │
    ▼
Instruction to AI
"Create a high-level PRD from the hearing content.
 Since detailed functional specs will be managed in the sprint backlog,
 only include business goals, scope, key user stories, and a glossary."
    │
    ▼
What AI generates (lightweight version):
  ├── Requirements Definition (PRD) high-level (Ch. 1-4 + §5.3 Epics)
  ├── Functional/Non-functional Req. (SRS) (confirming non-functional & security reqs)
  ├── Basic Design Document (tech stack, overall architecture)
  ├── Architecture Decision Record (ADR) + BMAD Architect Checklist (§10)
  └── Initial Product Backlog (list of epics and user stories)
    │
    ▼
Additional instruction to AI
"Prioritize the backlog items using the MoSCoW method and
 identify what to work on for the first 2-3 sprints."
    │
    ▼
Environment Setup & CLAUDE.md Creation
"Create CLAUDE.md and AI Coding Standards based on this design document."
```

**Sprint 0 Deliverables**

| Deliverable | Weight | Notes |
|---|---|---|
| Project Brief (BMAD) | Optional | Pre-PRD vision doc. Use for medium/large projects. |
| Requirements Definition (PRD) High-level | Lightweight | Chapters 1-4 + §5.3 Epics. Details managed in the backlog. |
| Functional/Non-functional Req. (SRS) | Non-functional & security only | Functional requirements added to the backlog. |
| Basic Design Document | Lightweight | Architecture and tech selection only. BMAD Architect Checklist completed. |
| Initial Backlog | Continuously updated | Updated throughout the sprints. |
| CLAUDE.md / AI Coding Standards | First version | Updated every sprint. |

---

### Sprint N (2 weeks each): Iterative Development

```
Sprint Planning (Human + AI)
"Review this sprint's backlog items and
 help with task breakdown and SP estimation."
    │
    ▼
[BMAD optional] Create Story File (tpl/story_en.md)
  Tech Lead persona: AC in Given/When/Then, tasks, dev notes
  → stories/EP-01-US-012-feature-name.md
    │
    ▼
Create PRP (per task) — `prp-plan` skill
"Create an implementation instruction sheet (PRP) for US-012.
 Include acceptance criteria, constraints, and related files.
 Set story_id: EP-01-US-012 in YAML to link to the story file."
    │
    ▼
AI Implementation (loop per task) — `prp-implement` skill
  ├── DB migration
  ├── API endpoint
  ├── Frontend component (referencing Figma)
  └── Test code (stubs derived from AC test_hint fields)
    │
    ▼
Harness evaluation → iterate until min_score met
    │
    ▼
Human code review → Merge → Staging confirmation
    │
    ▼
Sprint Review (Demo → Customer feedback)
    │
    ▼
Retrospective (KPT)
"Summarize this sprint's KPT:
 Keep: Code review was smooth.
 Problem: Misalignment on API design occurred.
 Try: Agree on the API design doc before implementation."
    │
    ▼
Backlog Refinement → To the next sprint
```

**AI Instruction Patterns for Sprint N**

| Timing | Example Instruction |
|---|---|
| Planning | "Break down this user story into tasks and estimate SP." |
| Story File (BMAD) | "Using the Developer persona, create a story file at `stories/EP-01-US-012-customer-search.md` from the sprint backlog item US-012." |
| PRP Creation | "Run `prp-plan` — create PRP-012 for US-012. Set `story_id: EP-01-US-012` and derive `test_hint` from the story's ACs." |
| Implementation | "Run `prp-implement` — read CLAUDE.md and PRP-012, then implement." |
| Testing | "Create unit and integration tests in Jest for the implemented API." |
| Retrospective | "Summarize this sprint's retrospective in KPT format." |
| Backlog Update | "Add this review feedback to the backlog and update priorities." |

**Sprint N Deliverables**

| Deliverable | Description |
|---|---|
| Sprint Backlog | Updated from planning to completion. |
| Working Software | Verified on the staging environment. |
| Retrospective Record | KPT, team state, velocity. |
| Updated Backlog | Priorities updated for the next sprint. |

---

### Pre-Release (1 week): Final Confirmation & Delivery

```
Deliverables from all sprints
    │
    ▼
Instruction to AI (Testing)
"Create acceptance test cases for all features.
 Create them based on the acceptance criteria in the backlog."
    │
    ▼
Instruction to AI (Document preparation)
"Create a user manual and administrator manual based on the
 features implemented in all sprints."
"Create release notes based on the completed stories in the sprint backlogs."
    │
    ▼
What AI generates:
  ├── Test Result Report
  ├── User Manual (for users)
  ├── Administrator Manual
  ├── Release Notes v1.0.0
  └── Environment Setup Guide
    │
    ▼
Human prepares the acceptance confirmation → Submit to customer and get signature
  └── Acceptance Confirmation (List of deliverables, acceptance test results, customer signature)
```

---

## Template List

> Legend: **★Required** = Essential for AI development (cannot be omitted) **[S△]** = Optional for small scale **[S×]** = Omittable for small scale **[MIG]** = Only if migration is involved

### Common to All Phases

| Template | File | Purpose |
|---|---|---|
| Issue Tracker | [tpl/issue-tracker_en.md](tpl/issue-tracker_en.md) | Centralized management of issues, concerns, and decisions for the entire project. |
| Meeting Minutes | [tpl/meeting-minutes_en.md](tpl/meeting-minutes_en.md) | Record of meeting decisions and action items. |

### BMAD Artifacts

> Use these when combining BMAD personas with Superpowers skills. See the [BMAD + Superpowers](#bmad--superpowers-macro-micro-workflow) section for the full workflow.

| Template | File | Purpose |
|---|---|---|
| Project Brief **[S×]** | [tpl/project-brief_en.md](tpl/project-brief_en.md) | Pre-Sprint 0 entry point. Captures product vision, personas, and Epic overview. Produced by Analyst + PM personas. |
| Story File **[S△]** | [tpl/story_en.md](tpl/story_en.md) | Per-story artifact (`stories/EP-XX-US-YYY-*.md`). Bridges sprint backlog to PRP execution. One file per story. |

### Sprint Management (Agile)

| Template | File | Purpose |
|---|---|---|
| Sprint Backlog **★Required** | [tpl/sprint-backlog_en.md](tpl/sprint-backlog_en.md) | Manage sprint goals, user stories, SP, and status. Includes Story File and PRP File columns for BMAD traceability. |
| Retrospective | [tpl/retrospective_en.md](tpl/retrospective_en.md) | KPT-style retrospective, team motivation, velocity record. |

### Phase 1: Requirements Definition

| Template | File | Purpose |
|---|---|---|
| Requirements Definition (PRD) **★Required** | [tpl/prd_en.md](tpl/prd_en.md) | Business goals, user stories, scope, glossary. |
| Functional/Non-Functional Req. (SRS) **★Required** | [tpl/srs_en.md](tpl/srs_en.md) | Detailed definition of functional, non-functional, and security requirements. |
| Business Flow Diagram **[S△]** | [tpl/business-flow_en.md](tpl/business-flow_en.md) | As-Is / To-Be business flows (Mermaid). |
| Migration Requirements **[MIG]** | [tpl/migration-requirements_en.md](tpl/migration-requirements_en.md) | Data migration, cutover procedures, handover plan (for existing projects). |
| Operations Requirements **[S△]** | [tpl/operations-requirements_en.md](tpl/operations-requirements_en.md) | Definition of training, monitoring, backup, and maintenance systems. |

### Phase 2: Design (Basic & Detailed)

| Template | File | Purpose |
|---|---|---|
| Basic Design (Architecture, Tech Stack) **★Required** | [tpl/architecture_en.md](tpl/architecture_en.md) | System architecture, tech stack, security design. |
| DB Design **★Required** | [tpl/db-design_en.md](tpl/db-design_en.md) | ER diagram, table definitions, index design. |
| API Specification **★Required** [API] | [tpl/api-spec_en.md](tpl/api-spec_en.md) | Endpoint, request, and response definitions. |
| Screen Design **★Required** [UI] | [tpl/screen-design_en.md](tpl/screen-design_en.md) | Figma URL, input specs, validation, error definitions. |
| Architecture Decision Record (ADR) **[S×]** | [tpl/adr_en.md](tpl/adr_en.md) | Background, options, and reasons for technology choices. |

### Phase 1.5: Effort Estimation

| Template | File | Purpose |
|---|---|---|
| Effort Estimate **[S△]** | [tpl/estimate_en.md](tpl/estimate_en.md) | Phase-by-phase effort estimation, expected reduction from AI use. |

### Phase 3: AI Development Preparation

| Template | File | Purpose |
|---|---|---|
| CLAUDE.md **★Required** | [tpl/claude-md_en.md](tpl/claude-md_en.md) | Overall project instruction manual for the AI. |
| AI Coding Standards **[S△]** | [tpl/ai-coding-standards_en.md](tpl/ai-coding-standards_en.md) | Coding conventions for the AI to follow. |
| AI Implementation Instruction (PRP) **[S×]** | [tpl/prp_en.md](tpl/prp_en.md) | Task-specific implementation instruction sheet for the AI. |
| .claudeignore Sample **[S△]** | [tpl/claudeignore-sample_en.md](tpl/claudeignore-sample_en.md) | Sample configuration for token reduction and confidential file exclusion. |
| AI Utilization Metrics Sheet **[S△]** | [tpl/ai-metrics_en.md](tpl/ai-metrics_en.md) | Quantitative record of baseline and sprint-by-sprint AI utilization metrics. |

### Phase 5: Testing (Unit, Integration, System, Acceptance)

| Template | File | Purpose |
|---|---|---|
| Test Plan **[S×]** | [tpl/test-plan_en.md](tpl/test-plan_en.md) | Test policy, scope, schedule, pass/fail criteria. |
| Test Specification (Test Cases) **[S×]** | [tpl/test-cases_en.md](tpl/test-cases_en.md) | List of test cases for UT / IT / ST / UAT. |
| Test Result Report **★Required** | [tpl/test-report_en.md](tpl/test-report_en.md) | Test execution results, bug occurrence status, judgment on exit criteria. |
| Bug Tracking Sheet **★Required** | [tpl/bug-tracker_en.md](tpl/bug-tracker_en.md) | Bug registration, priority, and status management. |

### Phase 6: Delivery & Acceptance

| Template | File | Purpose |
|---|---|---|
| User Manual **[S△]** | [tpl/user-manual_en.md](tpl/user-manual_en.md) | Instruction manual for general users. |
| Administrator Manual **[S×]** | [tpl/admin-manual_en.md](tpl/admin-manual_en.md) | Operation and management procedure manual for administrators. |
| Release Notes **★Required** | [tpl/release-notes_en.md](tpl/release-notes_en.md) | List of changes and fixed bugs by version. |
| Environment Setup Guide **[S×]** | [tpl/env-setup_en.md](tpl/env-setup_en.md) | Setup procedures for development and production environments. |
| Acceptance Confirmation **★Required** | [tpl/acceptance_en.md](tpl/acceptance_en.md) | List of deliverables, acceptance test results, acceptance judgment, signature. |

---

## Checklist

### Checklist for Customer Deliverables

- [ ] Are customer-specific business terms and system names used consistently?
- [ ] Are technical terms replaced with plain language?
- [ ] Do screen names and feature names match the actual system?
- [ ] Is there a section for approvals and sign-offs?
- [ ] Does it contain any confidential information (internal server IPs, credentials)?
- [ ] Is the version, creation date, and revision history included?

### Checklist for Single-Task Principle

- [ ] Are areas of responsibility (Infra / API / FE / Mobile) clearly assigned?
- [ ] Are you running only one task in one terminal (not launching Agents in multiple terminals at once)?
- [ ] Are you starting the next task after committing and merging the previous one?
- [ ] Are you resetting the session with `/clear` when the task changes?
- [ ] Have you decided on the work to do while the AI is running (next PRP creation, documentation, communication)?
- [ ] Have you included a verification mechanism (test, type check, Lint command) in the instruction to the AI?
- [ ] Are you recording recurring AI issues in AGENTS.md?

### Checklist Before AI Development (New)

- [ ] Have you described the project's overall tech stack and conventions in CLAUDE.md?
- [ ] Have you specified the task's acceptance criteria and constraints in the PRP?
- [ ] Is the level of detail in the design documents sufficient for AI generation?
- [ ] Has a human reviewed the code generated by the AI?
- [ ] Have you configured `/commit` (for auto-generating commit messages)?
- [ ] Have you enabled the `code-reviewer` SubAgent (to be used after every code implementation)?
- [ ] If handling authentication or personal information, have you configured `security-reviewer`?

### Checklist Before AI Development (Existing)

- [ ] Have you had the AI read the existing code first?
- [ ] Have you described existing implementation patterns and prohibitions in CLAUDE.md?
- [ ] Have you specified which files in the existing code should be referenced in the PRP?
- [ ] Have you identified the scope of regression impact?
- [ ] Have you reviewed whether the AI-generated code matches existing patterns?
- [ ] Have you configured `/commit` (for auto-generating commit messages)?
- [ ] Have you enabled the `code-reviewer` SubAgent (for checking regressions)?

### Checklist for Agile (Scrum)

**Sprint 0**
- [ ] Have you finalized the non-functional requirements in the PRD and SRS (they won't change during sprints)?
- [ ] Have you set MoSCoW priorities for the initial backlog?
- [ ] Have you created CLAUDE.md and AI Coding Standards?
- [ ] Have you prepared the development and staging environments?

**Sprint N (Every Sprint)**
- [ ] Have you updated the sprint backlog (SP, assignee, status)?
- [ ] Have you created a PRP for each user story before instructing the AI?
- [ ] Have you code-reviewed and merged the AI-generated code?
- [ ] Have you confirmed the acceptance criteria on the staging environment?
- [ ] Have you recorded the retrospective (KPT)?
- [ ] Have you refined the backlog in preparation for the next sprint?

**Pre-Release**
- [ ] Have you met the DoD for all backlog items?
- [ ] Have you created the test result report?
- [ ] Have you prepared the manuals (user, admin)?
- [ ] Have you created the acceptance confirmation and obtained the customer's signature?

### Quantitative Measurement & Improvement Cycle

- [ ] Have you recorded the baseline before adoption (task completion time, code review time, bug detection count)?
- [ ] Are you measuring and recording productivity metrics on a sprint-by-sprint basis?
- [ ] Have you set AI utilization metrics, such as CLAUDE.md update frequency and PRP usage rate?
- [ ] Are you reflecting on the measurement results in the retrospective to make improvements for the next sprint?

---

## Harness Engineering — Execution Layer

> **What this is**: A semi-automated pipeline that turns specs (PRP) into production-ready PRs
> through a generator → evaluator loop. Specs become the executable contract; the harness enforces
> it before a human ever reviews the code.

### The Pipeline at a Glance

```
PRD → SRS → API Spec → Screen Design
                              │
                              ▼
                    PRP (structured YAML front-matter)
                              │
                    ┌─────────┴──────────┐
                    │  harness-runner.sh  │
                    └─────────┬──────────┘
                              │
              ┌───────────────┼───────────────────────┐
              │               │                       │
              ▼               ▼                       ▼
     Layer 1: Spec    Layer 2: Functional   Layer 3: System
     Compliance       Correctness           Behavior
     (generator +     (tests, types,        (E2E smoke,
      evaluator loop)  lint)                 contract check)
              │
              ▼
     Layer 4: Production Readiness
     (security scan, perf benchmark)
              │
     score ≥ min_score?
     YES → gh pr create   NO → feed eval back → retry (max N)
```

### Structured PRP (Machine-Readable)

Unlike prose PRPs, structured PRPs carry a YAML front-matter block that the harness reads directly:

```yaml
---
task_id: SCR-003
title: Customer List Screen
target_files:
  - src/pages/CustomerList.tsx
acceptance_criteria:
  - id: AC-1
    description: List renders with columns Name, Company, Email, Status
    type: functional
    test_hint: "render component, assert column headers visible"
quality_gate:
  min_score: 80
  max_iterations: 3
---
```

Use template: `tpl/prp-structured_en.md` | Schema: `tpl/prp-schema.json`

### Running the Harness

```bash
# 1. Install tools
brew install yq jq
pip install pyyaml

# 2. Make scripts executable (first time only)
chmod +x harness/*.sh scripts/*.sh

# 3. Validate your PRP
./scripts/validate-prp.sh path/to/PRP-003.md

# 4. Run the full harness
./harness/harness-runner.sh path/to/PRP-003.md

# 5. Dry run (no claude CLI calls, no PR creation)
./harness/harness-runner.sh path/to/PRP-003.md --dry-run
```

### What Each Script Does

| Script | Purpose |
|--------|---------|
| `harness/harness-runner.sh` | Main orchestrator — runs all 4 layers in a loop |
| `harness/generator-agent.md` | Claude agent: reads PRP + eval feedback → writes code |
| `harness/evaluator-agent.md` | Claude agent: scores code against each AC → outputs JSON |
| `harness/security-check.sh` | Layer 4: scans for hardcoded secrets, XSS, SQL injection |
| `scripts/validate-prp.sh` | Pre-flight: checks PRP YAML matches schema |
| `scripts/generate-test-stubs.sh` | Creates `__tests__/` skeleton files from AC test_hints |
| `scripts/drift-detect-api.sh` | Diffs api-spec.md endpoints vs actual route handlers |
| `scripts/drift-detect-db.sh` | Diffs db-design.md tables vs migration files |
| `scripts/contract-validate.sh` | Calls live API, checks response shape matches spec |
| `scripts/perf-benchmark.sh` | Measures p95 response time against threshold |
| `ci/spec-drift.yml` | GitHub Actions: runs drift detection on every PR |

### Full Example

See `example/` for a complete walkthrough from PRD to shipped PR:

```
example/
├── docs/
│   ├── prd.md              ← Step 1: Product requirements
│   ├── srs.md              ← Step 2: Non-functional & security requirements
│   ├── api-spec.md         ← Step 3: API contract
│   └── screen-design.md    ← Step 4: Screen layout + states
├── prp/
│   └── PRP-003-customer-list.md  ← Step 5: Structured PRP
├── src/
│   ├── pages/CustomerList.tsx    ← Step 5: Generated implementation
│   ├── hooks/useCustomerSearch.ts
│   └── stores/useCustomerStore.ts
├── __tests__/
│   └── CustomerList.test.tsx     ← Step 6: AC-driven tests
├── harness/
│   ├── eval-report-iter1.json    ← Iteration 1 (score 64 — FAIL)
│   └── eval-report-iter2.json    ← Iteration 2 (score 87 — PASS)
└── e2e/
    └── customer-list.spec.ts     ← Step 7: E2E smoke tests
```

### CI Integration

Add `ci/spec-drift.yml` to `.github/workflows/` to automatically detect drift between specs and
code on every pull request. The workflow validates:
- API spec endpoints → route handlers
- DB design tables → migration files
- All PRP files → schema compliance
