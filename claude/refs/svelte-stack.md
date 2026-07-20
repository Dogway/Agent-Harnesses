## Svelte Quick Reference Stack

Deviate only with a documented technical reason. Use the `/svelte-skills` Skills for architecture, preferences and code style.

### Core Framework

| Choice                                                                 | Why                                                                                                                                                                    |
| ---------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Svelte ^5.56` (runes: `$state, $derived, $effect, $props, $bindable`) | Explicit reactivity states, better TS support, component props, side effects, migrating from Svelte 4 or easier for AI agents to reason about than `$:` compiler magic |
| `SvelteKit ^2.66` for routing/SSR/SSG only                             | Keeps UI/routing separate from business logic                                                                                                                          |
| `TypeScript ^6.0` (strict)                                             | Type safety across the stack                                                                                                                                           |

**Business logic lives in services/repositories — never in `+page.server.ts`, `+server.ts`, or components.**

### Styling & UI

| Layer      | Choice                 | Why                                                                                                                                          |
| ---------- | ---------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| CSS        | `Tailwind CSS ^4.3`    | Fast iteration, no custom CSS sprawl, strong AI tooling support                                                                              |
| Components | `shadcn-svelte ^1.3`   | Unstyled, composable, accessible primitives — dialogs, drawers, sheets, tabs, tables, menus, dropdowns, popovers, forms, command palettes... |
| Components | `Fluent UI`            | for Windows-style apps                                                                                                                       |
| Icons      | `@iconify/svelte ^5.2` | One API, tree-shakeable, thousands of icon sets — don't mix icon libs                                                                        |

### Forms & Validation

| Need                           | Choice                     | Why                                                                 |
| ------------------------------ | -------------------------- | ------------------------------------------------------------------- |
| Forms (CRUD, dashboards, auth) | `Superforms ^2.30`         | Zod-integrated, client+server validation, progressive enhancement   |
| Multi-select / tagging         | `Svelte MultiSelect ^11.7` | Specialized input used *inside* Superforms, not a replacement       |
| Schema validation              | `Zod ^4.4`                 | Single source of truth — shared by forms, APIs, DB boundaries, DTOs |

### Data & Visualization

| Need                        | Choice                 | Why                                                                      |
| --------------------------- | ---------------------- | ------------------------------------------------------------------------ |
| Data tables/grids           | `TanStack Table ^8.21` | Don't build custom table logic                                           |
| Dashboards/analytics charts | `Layer Cake ^10.0`     | Native Svelte, flexible, performant — prefer over heavy chart frameworks |
| Workflow/node editors       | `Svelvet ^11.0`        | For automation builders, AI pipelines, n8n-style UIs                     |
| 3D graphics                 | `Threlte ^8`           | Native Svelte wrapper over Three.js — avoid raw Three.js unless required |

### Notifications

| Choice                     | Why                                        |
| -------------------------- | ------------------------------------------ |
| `svelte-french-toast ^1.2` | Simple, proven success/error/status toasts |

### State Management (in order of preference)

1. **Svelte 5 runes** — default for all local/component state
2. **Writable stores** — shared state across components
3. **Context API** — scoped dependency injection

Avoid external state libraries unless there's a hard requirement.

### Code Quality

| Choice       | Why                                                               |
| ------------ | ----------------------------------------------------------------- |
| `Biome ^2.5` | Replaces ESLint + Prettier — single fast config for lint + format |

### Testing

| Layer     | Choice                                                                                       |
| --------- | -------------------------------------------------------------------------------------------- |
| Unit      | `Vitest ^4.1` — utilities, services, domain logic                                            |
| Component | `Svelte Testing Library ^5.4` — UI + interaction + a11y, test behavior not implementation    |
| E2E       | `Playwright ^1.61` — auth, user workflows, critical flows (source of truth for app behavior) |

### Desktop Apps (Tauri 2 + SvelteKit)

```text
Tauri 2 + SvelteKit + Svelte 5 + Tailwind + shadcn-svelte
SQLite 3.46+ via Tauri SQL Plugin (repository pattern — never query SQL from UI) or PostgreSQL 17+ + Drizzle ORM ^0.44 (for bigger data heavy projects)
Tauri plugins for: filesystem, native dialogs, notifications, shell
```

### Web Apps (SvelteKit + Hono + Bun)

```text
Bun ^1.3 + Hono ^4.12 (sole API framework: auth, validation, business logic, DB access)
OpenAPI ^3.2 (contract-first, type generation)
Generated API client (no manual fetch wrappers)
```

### Project Structure

```text
src/
  lib/
    components/
    features/
    services/
    repositories/
    stores/
    schemas/
    types/
    utils/
    api/
  routes/
```

### At a Glance

```text
Svelte 5 · SvelteKit · TypeScript Strict · Tailwind v4 · shadcn-svelte
Iconify · Zod · Superforms · TanStack Table · svelte-french-toast
Biome · Vitest · Svelte Testing Library · Playwright

Desktop → Tauri 2 + SQLite
Web     → Bun + Hono + OpenAPI
Charts  → Layer Cake
Workflows → Svelvet
3D → Threlte
```
