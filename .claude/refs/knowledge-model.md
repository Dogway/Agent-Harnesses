# Knowledge Management

Every project has three layers of knowledge. Understanding the distinction prevents noise in CLAUDE.md and ensures lessons aren't lost.

## The Three Layers

| Layer         | Question                                           | Audience           | Lifetime                   |
| ------------- | -------------------------------------------------- | ------------------ | -------------------------- |
| **CLAUDE.md** | What is this? How does it work?                    | Assistant + humans | Stable across sessions     |
| **MEMORY.md** | What did I learn? What preferences emerged?        | Assistant only     | Session-derived, ephemeral |
| **ADR**       | Why was this decision made? Alternatives rejected? | Humans (team)      | Formal decision record     |

### CLAUDE.md — "What is this?"

Reference knowledge. Things that are **true** regardless of who's working on the project:

- Project identity, goals, value proposition
- Tech stack, architecture overview, data flow
- Commands, conventions, team standards
- Safety rules, linting, git style

**Write here when:** The fact is a reference that won't change mid-project.

### MEMORY.md — "What did I learn?"

Ephemeral knowledge, insights, findings or learnings derived from working with the user, so the assistant performs better next time:

- Debugging lessons ("Glob is project-scoped; use PowerShell tool instead")
- User preferences that emerged mid-work ("user prefers Drizzle over Prisma")
- Corrections ("don't chain shell workarounds after one failed attempt")
- External references worth returning to (tickets, dashboards, URLs)

**Write here when:** The fact only matters to the assistant. It would be noise in CLAUDE.md for a new developer.

### ADR — "Why was this decision made?"

Architecture Decision Records. Captures design reasoning, alternatives considered, and consequences:

- "Chose PostgreSQL over SQLite because of concurrent write requirements"
- "Rejected SvelteKit in favor of React — team already knows React"
- "Chose Bun over Node for runtime — faster cold starts, better edge pattern"

**Write here when:** A meaningful design/architectural choice is made that benefits from a permanent record. See scope rules below.

## The Funnel

Knowledge flows upward as it proves its value:

```
Session insight → MEMORY.md (ephemeral, assistant-only)
                    ↓
            Does it recur across sessions?
                    ↓
              Promote to CLAUDE.md (stable guideline)
                    ↓
            Does it recur across projects?
                    ↓
        Promote to global CLAUDE.md (universal principle)
```

**Apply to all project types:** greenfield, brownfield, non-code.

## Project-Type Scope

| Layer     | Greenfield                               | Brownfield                                          | Non-code                       |
| --------- | ---------------------------------------- | --------------------------------------------------- | ------------------------------ |
| CLAUDE.md | Always (funneled)                        | Always                                              | Always                         |
| MEMORY.md | Always (funneled)                        | Optional (for refactors, debugging or new features) | Always                         |
| ADR       | **Yes** — for every architectural choice | Optional (for refactors, debugging or new features) | No — no architecture decisions |
