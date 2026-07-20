# ADR (Architectural Decision Records)

**Location:** `.madr/` at project root, one file per decision:

```
.madr/
├── README.md              ← index of all ADRs
├── 0001-choose-postgresql-over-sqlite.md
├── 0002-choose-drizzle-over-prisma.md
├── 0003-rest-over-graphql.md
```

### ADR Index Format

```markdown
# Architecture Decision Records

| ADR | Title | Status | Date |
|-----|-------|--------|------|
| [0001](0001-use-nextjs.md) | Use Next.js as frontend framework | accepted | 2026-01-15 |
| [0002](0002-postgres-over-mongo.md) | PostgreSQL over MongoDB for primary datastore | accepted | 2026-01-20 |
| [0003](0003-rest-over-graphql.md) | REST API over GraphQL | accepted | 2026-02-01 |
```

### ADR Format (template)

```markdown
# ADR-NNN: [Decision Title]

**Date**: YYYY-MM-DD
**Status**: proposed | accepted | deprecated | superseded by ADR-NNNN

## Context
What is the issue that we're seeing that is motivating this decision or change?
[2-5 sentences describing the situation, constraints, and forces at play]

## Decision
What is the change that we're proposing and/or doing? Be specific
[1-3 sentences stating the decision clearly]

## Consequences
What follows from this decision? What trade-offs were made?
### Positive
- [benefit 1]
- [benefit 2]

### Negative
- [trade-off 1]
- [trade-off 2]

### Risks
- [risk and mitigation]

## Alternatives Considered
### Alternative 1: [Name]
- **Pros**: [benefits]
- **Cons**: [drawbacks]
- **Why not**: [specific reason this was rejected]

### Alternative 2: [Name]
- **Pros**: [benefits]
- **Cons**: [drawbacks]
- **Why not**: [specific reason this was rejected]
```

**Naming:** `<number>-<kebab-case-title>.md`. Numbers are sequential across the project.

**When to write:** At the end of a session where an architectural decision is finalized — not mid-debate, after the choice is made.

## Practical Test

Ask: **Would this still be relevant 6 months from now when a new developer picks up the project?**

| Answer                                                                       | Destination |
| ---------------------------------------------------------------------------- | ----------- |
| Yes — it's part of how this project works                                    | CLAUDE.md   |
| Yes — but only as context for me (the assistant) to avoid repeating mistakes | MEMORY.md   |
| Yes — and it documents a formal team decision with alternatives              | ADR         |


