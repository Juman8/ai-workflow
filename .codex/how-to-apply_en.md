# AI-Driven Development Rollout Guide (Change Management)

> A Change Management guide for applying AI-driven development across your organization.
> **Transforming people and processes** — not the technology itself — accounts for 90% of success.

---

## Rollout Phase Overview

```
Phase 0        Phase 1         Phase 2          Phase 3          Phase 4
Prepare/Design → Pilot → Expansion Prep → Company-wide → Adoption/Improvement
(1-2 months)  (1-3 months)   (1-2 months)    (3-6 months)   (ongoing)
```

---

## Phase 0: Prepare & Design

### Securing Executive Sponsorship

The first thing to do is **obtain commitment from leadership**.

- Position it not as "just paying for AI tools" but as "an investment in transforming development culture."
- Tie KPIs to business objectives (development speed → shorter TTM → competitive advantage).

### Anticipating Resistance to Change

| Resistance Pattern | Typical Concern | Response |
|-------------------|----------------|----------|
| Role anxiety | "Will AI take my job?" | Clarify: "AI is a pair partner; you are the decision-maker." |
| Quality anxiety | "Can I trust AI-written code?" | Show that a stronger review process actually raises quality. |
| Learning curve anxiety | "Do I have to learn yet another tool?" | Demonstrate how CLAUDE.md/PRP makes the **AI adapt** to the team. |
| Security concerns | "Will our code leak externally?" | Explain .claudeignore, Enterprise contracts, and data policies. |

---

## Phase 1: Pilot (Most Critical)

### Team Selection Criteria

```
Ideal pilot team:
  ✅ High motivation (never force it)
  ✅ Has new feature development (maintenance-heavy work sees fewer benefits)
  ✅ Tech lead is open to change
  ✅ 3–5 members (not too large, not too small)
  ❌ Projects already on fire (high risk of failure)
  ❌ Teams composed entirely of skeptics
```

### What to Measure in the Pilot

Run the baseline measurement in `tpl/ai-metrics_en.md` **without fail**.
Without numbers, you end up with a vague "it felt good" — and no data to justify wider rollout.

| Metric | Why It Matters |
|--------|---------------|
| Task completion time (SP/person-day) | Evidence for speed improvements |
| Code review comment count | Visualizing quality changes |
| AI-caused bug count | Quantifying risk (answer for skeptics) |
| Developer satisfaction (1–5) | Detecting "productivity up but burnout" |

### Failure Patterns and Countermeasures

| Failure Pattern | What Happens |
|----------------|-------------|
| Using AI without CLAUDE.md | AI goes off the rails → "Told you it's useless." |
| Tool adoption without training | Everyone uses it differently → no measurable effect |
| "Feel free to use it" with no goals | Most people simply don't use it |

---

## Phase 2: Expansion Preparation

### Cultivating Internal "Champions"

Select **2–3 Champions** from the pilot team to become internal instructors.

```
Champion responsibilities:
  - Conduct hands-on sessions for other teams
  - Help teams apply CLAUDE.md / PRP templates to their projects
  - Answer questions in internal Slack channels
  - Collect and share success and failure stories
```

> **Peer-to-peer spread** achieves far higher adoption rates than external training.

### Building a Knowledge Base

Prepare the following before expanding (this docs repository serves that purpose):

- [ ] Create an internal CLAUDE.md template (fixed tech stack version)
- [ ] Accumulate effective PRP patterns from the pilot in `docs/prp/`
- [ ] Document before/after case studies showing the impact of using AI

---

## Phase 3: Company-wide Rollout

### Staged Rollout Strategy

```
Wave 1 (Month 1-2): Pilot team + volunteer teams
Wave 2 (Month 3-4): All dev teams (make it the "default," not mandatory)
Wave 3 (Month 5-6): Expand to QA, infra, and documentation teams
```

### Training Design

| Audience | Content | Format |
|----------|---------|--------|
| All developers | How to write CLAUDE.md/PRP, basic usage | 3-hour hands-on |
| Tech leads | SubAgent usage, quality control, metrics measurement | Half-day workshop |
| Managers | Reading KPIs, risk handling, budget planning | 1-hour briefing |
| Executives | Reading ROI reports, competitive landscape | Executive summary |

### "Don't Mandate It — Make It Easy" Design

- Optionally integrate Claude Code review into CI/CD
- **Place CLAUDE.md in the repository from the start** (reducing the option to not use it)
- **Standardize** the AI reflection section of `tpl/retrospective_en.md` in Sprint Retrospectives

---

## Phase 4: Adoption & Improvement Cycle

### Continuous Improvement Mechanism

```
Every Sprint:
  Fill in the AI utilization retrospective section of retrospective.md
        ↓
Monthly:
  Measure effectiveness with ai-metrics.md → Report to managers
        ↓
Quarterly:
  Champions gather for a knowledge-sharing session
  Update CLAUDE.md/PRP templates
        ↓
Semi-annually:
  Measure ROI → Executive report → Reflect in next year's budget
```

---

## Common Failures and Countermeasures

| Failure | Cause | Countermeasure |
|---------|-------|----------------|
| No one uses it after a few months | Forced adoption, invisible results | Champion program + metrics visualization |
| Usage varies wildly across teams | No templates | Standardize CLAUDE.md/PRP as company standards |
| AI bug causes a crisis → ban issued | No review process | Track AI-caused bugs with `tpl/bug-tracker_en.md` |
| "Using it because management said to" | Top-down mandate | Build bottom-up success stories first |

---

## First Move: Action Plan

> The golden rule of change: **"Win small, speak with numbers, then expand"** beats a company-wide launch every time.

| Timing | Action |
|--------|--------|
| This week | Engage one tech lead and pilot CLAUDE.md in a single project |
| Next month | Measure the baseline using `tpl/ai-metrics_en.md` with that team |
| In 2 months | Present pilot results to leadership |
| In 3 months | Use those numbers to secure expansion budget |

---

## Related Documents

| Document | Role |
|----------|------|
| [tpl/claude-md_en.md](tpl/claude-md_en.md) | CLAUDE.md template defining project context for the AI |
| [tpl/prp_en.md](tpl/prp_en.md) | AI implementation instruction sheet template per task |
| [tpl/ai-metrics_en.md](tpl/ai-metrics_en.md) | Quantitative measurement table for AI utilization effectiveness (baseline to measurement) |
| [tpl/retrospective_en.md](tpl/retrospective_en.md) | Sprint retrospective with AI utilization reflection section |
| [tpl/bug-tracker_en.md](tpl/bug-tracker_en.md) | AI-caused bug tracking and root cause analysis |
| [tpl/claudeignore-sample_en.md](tpl/claudeignore-sample_en.md) | .claudeignore sample for token reduction and confidential file protection |
