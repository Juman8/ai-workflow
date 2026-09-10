# 🤖 AI Agentic Workflow Boilerplate

A standardized, multi-agent workflow architecture for AI-assisted coding (Codex, Claude, Cursor, Aider). This script instantly scaffolds a highly disciplined `.codex/` environment into any project, enforcing a strict Human-in-the-loop and Parallel Review process.

## 🌟 Why this Workflow?

When working with Autonomous Coding Agents, giving them unrestricted access can lead to chaotic commits and architectural drift. This workflow solves that by dividing AI into "departments":
- **Main Agent**: Plans and implements features.
- **Review Agents**: Specialized agents (UI/UX, Security, Performance, Code Quality) that run in parallel and *only* read code.
- **Human Gate**: AI cannot modify code without explicit human approval of the plan.

## 🏗 Workflow Architecture

```mermaid
flowchart TD
    A[DISCOVERY: Understand Requirements] --> B[PLANE: Create/Update Issue]
    B --> C[PLAN: Files, Arch, Risks, Tests]
    C --> D{HUMAN GATE: APPROVE}
    D -- NO --> C
    D -- YES --> E[IMPLEMENT: Main Agent]
    E --> F[PARALLEL REVIEW]
    
    subgraph F [PARALLEL REVIEW]
        F1[Code Quality]
        F2[UI/UX]
        F3[Performance]
        F4[Security]
        F5[Testing]
    end
    
    F --> G[AGGREGATE FINDINGS]
    G --> H{Findings to Fix?}
    H -- YES --> E
    H -- NO --> I[FINAL SECURITY REVIEW]
    I --> J[FINAL CHECK: compile, lint, test]
    J --> K[HUMAN REVIEW: DONE]
