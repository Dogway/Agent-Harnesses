# Environment

- **OS:** Windows 10 Pro for Workstations es-ES
- **CPU:** i7-4790K 4c/8t
- **GPU:** RTX 5060 Ti 16 GB
- **RAM:** 32 GB DDR3
- **Shell:** PowerShell
- **Units**: Spanish Units
- **Language**: en-US (except stated otherwise), es-ES (secondary)

---

# Safety Rules

Always ask for confirmation before:

- Installing any dependency (any language, any package manager), unless stated otherwise.
- Running any destructive operation: deleting files or folders, overwriting data, dropping or truncating a database, resetting state.

When in doubt about whether an operation is destructive, ask.

---

# Agent Behaviour Guidelines

Behavioral guidelines to reduce common LLM coding mistakes.

> Full rules: [`~/.claude/refs/agent-guidelines.md`](./refs/agent-guidelines.md)

0. **Hard Rules** — You MUST read this without exception. Mandatory PowerShell tool on Windows for all system commands (eg. PowerShell()). Bash is restricted to Read/Glob/Grep and cross-platform CLIs. Full rules: `~/.claude/refs/agent-guidelines.md#0-hard-rules`. Glob/Grep are project-scoped only.
1. **Think first** — State assumptions. Surface tradeoffs. Ask when confused.
2. **Simplicity** — Minimum code that solves the problem. Nothing speculative.
3. **Surgical changes** — Touch only what the request requires. Remove only what your changes orphan.
4. **Goal-driven** — Define a verifiable success criterion before coding. Loop until it passes.

---

# Knowledge Management

> Full model: [`~/.claude/refs/knowledge-model.md`](./refs/knowledge-model.md)

Every project has three layers of knowledge, each answers a different question.

Understanding the distinction prevents noise in CLAUDE.md and ensures lessons aren't lost.

| Layer         | Question                        | Who reads it   | When to write                              |
| ------------- | ------------------------------- | -------------- | ------------------------------------------ |
| **CLAUDE.md** | What is this? How does it work? | Everyone       | Stable facts: stack, commands, conventions |
| **MEMORY.md** | What did I learn this session?  | Assistant only | Lessons, corrections, emerging preferences |
| **ADR**       | Why was this decided?           | Humans (team)  | After an architectural choice is finalized |

**The funnel:** session insight → `MEMORY.md` → (if it recurs) → `CLAUDE.md` → (if universal) → global `CLAUDE.md`.

**ADRs:** greenfield always. Brownfield and non-code only for significant refactors or new features. Location: `.madr/`.

---

# ADR Format

> Full template: [`~/.claude/refs/adr-template.md`](./refs/adr-template.md)

**Location:** `.madr/` — one file per decision, sequential numbering.

```
.madr/
├── README.md ← index table of all ADRs
├── 0001-kebab-case-title.md
```

**When to write:** after a decision is finalized, not mid-debate.
**Practical test:** would a new developer still care about this in 6 months?

Each ADR covers: **Context** · **Decision** · **Consequences** · **Alternatives Considered**.

---

# Tooling Philosophy

Prefer well-established libraries and Skills or CLI tools over custom scripts for common tasks (file watching, argument parsing, HTTP clients, date handling, CSV parsing, environment config, etc.). Only build custom implementations when no suitable tool or skill exists or existing options are a poor fit for the use case. When in doubt, ask before writing something from scratch.

## CLI Tools

- **HARD RULE: On Windows, use the `PowerShell` tool for all system commands.** See `~/.claude/refs/agent-guidelines.md#0-hard-rules` for the full specification.
- **Windows**: PowerShell tool
- **Bash only allowed for:** `Read()`/`Glob()`/`Grep()`, and those listed in `~/.claude/refs/agent-guidelines.md#0-hard-rules`
- **NEVER:** Wrap `powershell -Command` inside Bash — use the PowerShell tool directly `PowerShell()`.
- **NEVER:** Pass `$env:VAR=...; cmd` or any PowerShell syntax inside Bash — Bash on this platform mangles PowerShell env-var assignment, semicolons, and quoting. Always set env vars and run commands via the PowerShell tool directly.
- **Scripting**: Python + `typer` (rich ecosystem, Claude-native, good for data/AI/automation tasks) (use PowerShell if the ecosystem is Windows so PATH doesn't bypass shims)
- **Scripting Alt**: TypeScript + Bun (when the CLI lives in a web project and shares types)

---

# Package Management

Never install programs, packages, modules or libraries globally, outside the project folder scope.

- **JavaScript / TypeScript:** use `pnpm`. Never use `npm` or `yarn` unless the project explicitly requires it.
- **Python:** use `pyenv-win` to manage Python versions and always create a `.venv` virtual environment inside the project folder. Never `pip install` outside a venv.
  - Example:    
    1) first check with `pyenv versions`
    2) since 3.12.10 (ask first required version) is present you do `pyenv local 3.12.10`
    3) create venv `python -m venv .venv`
    4) activate it `.\.venv\Scripts\activate`
    5) upgrade pip just in case `pip install --upgrade pip`
    6) install packages, in this case no requirements.txt so `pip install ...`

---

# Linting

- **JavaScript / TypeScript:** Follow the project's linter config if present; otherwise default to `Biome`. Run the formatter before considering any task done.
- **Python:** Follow the project's linter config if present; otherwise default to `ruff`.

---

# Preferred Stacks for Greenfield Projects

Use these defaults for greenfield work unless the user specifies otherwise or they are a clear mismatch for the task.

## Web Apps

**Frontend**

- **Framework**: SvelteKit on Svelte 5 — using runes (lightweight shell approach — avoid over-engineering)
- **UI components**: shadcn-svelte
- **Graphics**: Threlte with WebGPU Renderer (default); Babylon.js WebGPU Engine for complex scenes (prefer WebGPU; fall back to WebGL only if unavailable)
- **GPU compute:** Thretle (abstraction layer). Raw WebGPU API (`navigator.gpu`) available for advanced use cases not covered by Thretle

**Backend**

- **Runtime**: Bun (preferred); Node.js for SvelteKit via adapter-node
- **Framework**: Hono (prefer over Express for new projects)
- **Pattern**: thin API layer — keep routes simple, logic in services

**Database**

- PostgreSQL + Drizzle ORM for persistence
- tRPC API builder
- Default to no database unless the task clearly requires it

## Mobile — Android Only

- Jetpack Compose (Kotlin) — native, modern, no abstraction layer. Use along OpenAPI.

## Mobile — Multiplatform

- Compose Multiplatform (Kotlin) — preferred; natural extension of Jetpack Compose. Use along OpenAPI.

## Desktop / Compiled

- Tauri ^2.11 + SvelteKit — Windows, macOS, Linux (no mobile targets)

---

# Svelte Stack

> Full reference: [`~/.claude/refs/svelte-stack.md`](./refs/svelte-stack.md)

**Core:** Svelte ^5.56 (runes only — no `$:`) · SvelteKit ^2.66 · TypeScript ^6 (strict) · Tailwind ^4.3 · Biome ^2.5

**UI:** shadcn-svelte ^1.3 or Fluent UI · Iconify ^5.2 (one icon lib, no mixing)

**Forms:** Superforms ^2.30 + Zod ^4.4 · Svelte MultiSelect ^11.7 for tagging

**Data:** TanStack Table ^8.21 · Layer Cake ^10 · Svelvet ^11 (workflows) · Threlte ^8 (3D)

**State:** runes first → writable stores → context API. No external state libs unless forced.

**Notifications:** svelte-french-toast ^1.2

**Testing:** Vitest ^4.1 (unit) · Svelte Testing Library ^5.4.2 (component) · Playwright ^1.61 (E2E)

--

**Web:** Bun ^1.3 + Hono ^4.12 · OpenAPI ^3.2 contract-first · generated API client

**Desktop:** Tauri ^2.11 + SQLite 3.46+ (small) or PostgreSQL 17+ + Drizzle ORM ^0.44 (data-heavy)

**Rule:** business logic in `services/` and `repositories/` — never in routes or components.

---

# Git

- Commit message style: short imperative, sentence case, no period — e.g. `Add login page`, `Fix null check in user resolver`.
- Keep commits focused and atomic — one logical change per commit.
- Always ask for confirmation before creating a commit or pushing.

---

# Tools & MCPs

- **Browser automation:** Playwright with Chrome in headless mode. Already available — do not install alternatives.
- **Codebase analysis:** `codegraph` MCP maps call flows and module relationships. Suggest it when navigating unfamiliar code or before large refactors.
- **`windows-mcp`** — Windows system operations (registry, processes, environment variables, etc.)
- **`server-filesystem`** — direct filesystem read/write access.

---

# Session Workflow

When starting work in a project for the first time:

1. **Ask**, 1) Is this a Greenfield Project? 2) Is this a Brownfield Project? 3) Is this a non-code related project?
2. `/init-folders` — scaffolds the project's Claude Code harness.
3. `/init` — Claude Code's built-in project initialisation (populates CLAUDE.md, good for Brownfield)
4. Load automatically the required Skills for the project, that is `/code-style`, Programming Language, etc

For planning and feature work, suggest the following Skills based on context:

- `/feature-dev` — structured feature development workflow.
- `/setup-matt-pocock-skills` then `/ask-matt` — Matt Pocock's grilling + engineering workflow entry point.
- `/to-prd` — when the project already has a codebase and needs a PRD derived from it. — Matt Pocock's
- `/grill-with-docs` — when domain terminology needs pinning down before coding. — Matt Pocock's
- `/tdd` — when the task calls for a test-first approach. — Matt Pocock's

When the user is unsure what automation to use, trigger `claude-code-setup:claude-automation-recommender`.

---

# User Skills

There are three layers of Skills, local, custom (global), official (global):

**Local**: First check local Skills at `./.claude/skills/`. or `/.claude/plugins/`.

**Custom**: They are placed at `~/.claude/skills/`.

**Official**: Official Skills are located inside plugins at `~/.claude/plugins/` , they trigger automatically and are not listed here.

Skills are loaded into context at the start of the session so, before answering, check if there is a skill that can enhance your response.

| Skill                  | When to use                                                                                                                   |
| ---------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| `init-folders`         | First session in any project — scaffolds the Claude Code harness                                                              |
| `find-skills`          | User wants to discover and install skills from the open agent skills ecosystem                                                |
| `graphify`             | Convert any content or codebase into a knowledge graph                                                                        |
| `review-claudemd`      | Review or improve a project-level or global CLAUDE.md                                                                         |
| `markitdown`           | Convert documents, URLs, or web content to Markdown                                                                           |
| `pdf`                  | PDF read, extract, merge, split, or fill operations                                                                           |
| `ffmpeg-skill`         | Skill related to everything media; audio, video, images...                                                                    |
| `tauri`                | Tauri desktop app scaffolding and development patterns                                                                        |
| `windows-it`           | Windows IT and system administration tasks                                                                                    |
| `yt-dlp`               | Download or process media via yt-dlp                                                                                          |
| `tiktok-app-marketing` | TikTok app marketing workflows                                                                                                |
| `half-clone`           | Clone the latter half of the current conversation, discarding earlier context to reduce token usage. Alternative to `handoff` |
| `market`               | Comprehensive web marketing analysis and audit automation                                                                     |

## graphify

- **graphify** (`~/.claude/skills/graphify/SKILL.md`) - any input to knowledge graph. Trigger: `/graphify`
  When the user types `/graphify`, invoke the Skill tool with `skill: "graphify"` before doing anything else.

---

# Session Preflight

Quick checklist before starting any session.

## Context

- [ ] Project type identified — greenfield / brownfield / non-code
- [ ] Stack alignment confirmed (deviation documented if not using defaults)
- [ ] Local skills checked — `./.claude/skills/`, `./.claude/plugins/`

## Setup (first session only)

- [ ] `/init-folders` run — scaffolds CLAUDE.md, MEMORY.md, `.madr/`
- [ ] `/init` run if brownfield — populates CLAUDE.md from existing codebase
- [ ] Relevant skills loaded — code-styles, svelte-skills, feature-dev, tdd, etc.

## Safety (HITL)

- [ ] Confirm before any dependency install (pnpm / pip) - no silent nor global installs
- [ ] Confirm before destructive ops — delete, drop, truncate, reset, overwrite
- [ ] Confirm before commit or push — short imperative, sentence case, no period

## Tooling

- [ ] JS → pnpm only — never npm or yarn unless project demands it
- [ ] Python → pyenv-win + `.venv` inside project folder — `pyenv versions` → `pyenv local X` → `python -m venv .venv` → `.\.venv\Scripts\activate`
- [ ] Linting config present — Biome (Svelte) or Prettier+ESLint; ruff for Python
- [ ] Shell → PowerShell only — never fall back to Bash for system commands on Windows. You MUST have read `~/.claude/refs/agent-guidelines.md#0-hard-rules` without exceptions.

## Knowledge (local)

- [ ] CLAUDE.md present and accurate - reference facts — stack, commands, conventions
- [ ] MEMORY.md seeded if session had prior learnings — debugging lessons, user prefs, corrections

## Role

- [ ] expert role, uses CoT

<!-- CODEGRAPH_START -->

## CodeGraph

This project has a CodeGraph MCP server (`codegraph_*` tools) configured. CodeGraph is a tree-sitter-parsed knowledge graph of every symbol, edge, and file. Reads are sub-millisecond and return structural information grep cannot.

### When to prefer codegraph over native search

Use codegraph for **structural** questions — what calls what, what would break, where is X defined, what is X's signature. Use native grep/read only for **literal text** queries (string contents, comments, log messages) or after you already have a specific file open.

| Question                                      | Tool                |
| --------------------------------------------- | ------------------- |
| "Where is X defined?" / "Find symbol named X" | `codegraph_search`  |
| "What calls function Y?"                      | `codegraph_callers` |
| "What does Y call?"                           | `codegraph_callees` |
| "What would break if I changed Z?"            | `codegraph_impact`  |
| "Show me Y's signature / source / docstring"  | `codegraph_node`    |
| "Give me focused context for a task/area"     | `codegraph_context` |
| "See several related symbols' source at once" | `codegraph_explore` |
| "What files exist under path/"                | `codegraph_files`   |
| "Is the index healthy?"                       | `codegraph_status`  |

### Rules of thumb

- **Answer directly — don't delegate exploration.** For "how does X work" / architecture / trace questions, answer with 2-3 codegraph calls: `codegraph_context` first, then ONE `codegraph_explore` for the source of the symbols it surfaces. Codegraph IS the pre-built index, so spawning a separate file-reading sub-task/agent — or running a grep + read loop — repeats work codegraph already did and costs more for the same answer.
- **Trust codegraph results.** They come from a full AST parse. Do NOT re-verify them with grep — that's slower, less accurate, and wastes context.
- **Don't grep first** when looking up a symbol by name. `codegraph_search` is faster and returns kind + location + signature in one call.
- **Don't chain `codegraph_search` + `codegraph_node`** when you just want context — `codegraph_context` is one call.
- **Don't loop `codegraph_node` over many symbols** — one `codegraph_explore` call returns several symbols' source grouped in a single capped call, while each separate node/Read call re-reads the whole context and costs far more.
- **Index lag**: the file watcher debounces ~500ms behind writes; don't re-query immediately after editing a file in the same turn.

### If `.codegraph/` doesn't exist

The MCP server returns "not initialized." Ask the user: *"I notice this project doesn't have CodeGraph initialized. Want me to run `codegraph init -i` to build the index?"*

<!-- CODEGRAPH_END -->
