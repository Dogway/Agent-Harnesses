# Anthropic Marketplace Plugins & Skills Guide

Three official Anthropic marketplaces.

- **agent-skills/** — Anthropic Agent Skills (16 skills)
- **knowledge-work-plugins/** — Knowledge Work plugins (18 plugins)
- **claude-plugins-official/** — Claude Plugins Official (37 plugins + 14 external)

---

## 1. Anthropic Agent Skills

Official skills from Anthropic.

| Skill                     | Description                                                                                                                           |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| **algorithmic-art**       | Creating algorithmic art using p5.js with seeded randomness and interactive parameter exploration.                                    |
| **brand-guidelines**      | Applies Anthropic's official brand colors and typography to any artifact that needs the Anthropic look-and-feel.                      |
| **canvas-design**         | Create beautiful visual art in .png and .pdf using design philosophy. Triggers on poster, art, or static design requests.             |
| **claude-api**            | Reference for the Claude API / Anthropic SDK — model IDs, pricing, params, streaming, tool use, MCP, agents, caching, token counting. |
| **doc-coauthoring**       | Structured workflow for co-authoring documentation, proposals, technical specs, and decision docs.                                    |
| **docx**                  | Create, read, edit, and manipulate Word documents (.docx / .dotx) — formatting, tables of contents, tracked changes, images.          |
| **frontend-design**       | Guidance for distinctive, intentional visual design — aesthetic direction, typography, and non-templated UI choices.                  |
| **internal-comms**        | Templates and workflows for internal communications: status reports, leadership updates, company newsletters, FAQs, incident reports. |
| **learn**                 | Intellectual understanding mode — teaches how/why things work. Triggers on teach/explain/ELI5/walk-me-through/quiz me requests.       |
| **mcp-builder**           | Guide for creating high-quality MCP (Model Context Protocol) servers in Python (FastMCP) or Node/TypeScript (MCP SDK).                |
| **pdf**                   | Full PDF toolkit: read, extract text/tables, merge, split, rotate, watermarks, forms, encryption, images, OCR.                        |
| **pptx**                  | Create and manipulate PowerPoint decks — slides, pitch decks, speaker notes, templates, comments.                                     |
| **skill-creator**         | Create new skills, modify existing ones, run evals, benchmark performance with variance analysis.                                     |
| **slack-gif-creator**     | Knowledge and utilities for creating animated GIFs optimized for Slack messages.                                                      |
| **theme-factory**         | Toolkit for styling artifacts (slides, docs, HTML pages) with 10 pre-set themes or on-the-fly generated ones.                         |
| **webapp-testing**        | Toolkit for testing local web apps using Playwright — UI debugging, browser screenshots, log viewing.                                 |
| **web-artifacts-builder** | Tools for multi-component HTML artifacts using React, Tailwind CSS, and shadcn/ui — state management, routing.                        |
| **xlsx**                  | Open, read, edit, fix, or create spreadsheets (.xlsx, .xlsm, .csv, .tsv) — formulas, formatting, charting, data cleaning.             |

---

## 2. Knowledge Work Plugins

Domain-specific plugins for specialized workflows.

| Plugin                       | Description                                                                                                                                                     |
| ---------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **bio-research**             | Preclinical research tools: literature search, genomics analysis, target prioritization. Consolidates 11 MCP servers + 5 analysis skills for life sciences R&D. |
| **cowork-plugin-management** | Plugin management utilities for the Cowork desktop application ecosystem.                                                                                       |
| **customer-support**         | Ticket triage, escalation management, response drafting, customer research, and knowledge base authoring for support teams.                                     |
| **data**                     | SQL queries, data exploration, visualization, dashboards, and insight generation. Works with any data warehouse or analytics stack.                             |
| **design**                   | Design critique, system management, UX writing, accessibility, research synthesis, and developer handoff.                                                       |
| **engineering**              | Standups, code review, architecture decisions, incident response, debugging, and technical documentation for engineering teams.                                 |
| **enterprise-search**        | Unified search across all company tools — email, chat, documents, wikis — in one query with source attribution.                                                 |
| **finance**                  | Month-end close, journal entries, account reconciliation, financial statements, variance analysis, and SOX audit support.                                       |
| **human-resources**          | Recruiting, onboarding, performance management, policy guidance, and compensation analysis for people ops teams.                                                |
| **legal**                    | Contract review, NDA triage, compliance workflows, legal briefings, and templated responses configurable to org-specific playbooks.                             |
| **marketing**                | Content creation, campaign planning, brand voice management, competitive analysis, and performance reporting.                                                   |
| **operations**               | Vendor management, process documentation, change management, capacity planning, compliance tracking, and resource planning.                                     |
| **partner-built**            | Community-contributed plugins curated by Anthropic.                                                                                                             |
| **pdf-viewer**               | Interactive PDF viewer: annotate, fill forms, stamp approvals, place signatures, download annotated copies.                                                     |
| **product-management**       | Feature specs, roadmaps, stakeholder communication, user research synthesis, competitor analysis, and product metrics tracking.                                 |
| **productivity**             | Persistent task management, workplace memory, and visual dashboard — Claude learns your people, projects, and terminology.                                      |
| **sales**                    | Prospecting, outreach, pipeline management, call preparation, and deal strategy for sales teams.                                                                |
| **small-business**           | 15 building-block skills + 15 workflows for payroll, customer issues, pricing, and general small business operations.                                           |

---

## 3. Claude Plugins Official

Core plugins from Anthropic's official marketplace.

### Development & Architecture

| Plugin                   | Description                                                                                                                                                                                                                                                           |
| ------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **agent-sdk-dev**        | Comprehensive toolkit for creating and verifying Claude Agent SDK applications in Python and TypeScript.                                                                                                                                                              |
| **claude-code-setup**    | Analyzes codebases and recommends tailored automations: hooks, skills, MCP servers.                                                                                                                                                                                   |
| **claude-md-management** | Tools to maintain and improve CLAUDE.md files — audit quality, capture session learnings, keep project memory current.                                                                                                                                                |
| **code-modernization**   | Point a legacy codebase at Claude and get: executive assessment, architecture map, mined business rules, modernization brief, scaffolded new code with behavior-equivalence tests. Pipeline: `preflight → assess → map → extract-rules → brief → transform → harden`. |
| **code-review**          | Automated PR review using multiple specialized agents in parallel with confidence-based scoring to filter false positives.                                                                                                                                            |
| **code-simplifier**      | Agent for simplifying and modernizing code.                                                                                                                                                                                                                           |
| **commit-commands**      | Streamline git workflow: single slash commands for commit, push, and PR creation.                                                                                                                                                                                     |
| **feature-dev**          | Structured 7-phase feature development workflow with specialized agents for exploration, architecture design, and quality review.                                                                                                                                     |
| **frontend-design**      | Production-grade frontend interfaces with bold aesthetics, distinctive typography, and non-generic AI styling.                                                                                                                                                        |
| **hookify**              | Create custom hooks to prevent unwanted behaviors by analyzing conversation patterns — no JSON editing required.                                                                                                                                                      |
| **math-olympiad**        | Competition math solver with adversarial verification (defeats self-verification bias).                                                                                                                                                                               |
| **mcp-server-dev**       | Three skills for designing and building MCP servers: full app, server core, and MCPB packaging.                                                                                                                                                                       |
| **mcp-tunnels**          | Connect Claude to MCP servers on private networks via outbound-only Anthropic tunnels — no inbound ports needed.                                                                                                                                                      |
| **plugin-dev**           | Seven specialized skills for building Claude Code plugins: hooks, MCP integration, structure, marketplace publishing.                                                                                                                                                 |
| **pr-review-toolkit**    | Six expert review agents covering code comments, test coverage, error handling, type design, quality, and simplification.                                                                                                                                             |
| **project-artifact**     | Generate living status pages — single self-contained HTML files with workstream tabs, success criteria, and next steps.                                                                                                                                               |
| **ralph-loop**           | Iterative self-referential AI development loops — persistent `while true` agent that improves its work until completion.                                                                                                                                              |
| **security-guidance**    | Three-layer security review: pattern warnings on edit/write, LLM diff review, agentic commit review for multi-file vulnerabilities.                                                                                                                                   |
| **session-report**       | Analyze and report on Claude Code session activity with HTML templates.                                                                                                                                                                                               |
| **skill-creator**        | Create new skills, improve existing ones, run evals, benchmark performance with variance analysis.                                                                                                                                                                    |

### Language Servers (LSP)

| Plugin                | Language | Description                                                                         |
| --------------------- | -------- | ----------------------------------------------------------------------------------- |
| **clangd-lsp**        | C/C++    | Code intelligence, diagnostics, formatting for `.c`, `.h`, `.cpp`, `.hpp`.          |
| **csharp-lsp**        | C#       | Code intelligence and diagnostics for `.cs`.                                        |
| **gopls-lsp**         | Go       | Code intelligence, refactoring, analysis for `.go`.                                 |
| **jdtls-lsp**         | Java     | Code intelligence and refactoring for `.java`.                                      |
| **kotlin-lsp**        | Kotlin   | Code intelligence, refactoring, analysis for `.kt`, `.kts`.                         |
| **lua-lsp**           | Lua      | Code intelligence and diagnostics for `.lua`.                                       |
| **php-lsp**           | PHP      | Code intelligence and diagnostics for `.php`.                                       |
| **pyright-lsp**       | Python   | Static type checking and code intelligence for `.py`, `.pyi`.                       |
| **ruby-lsp**          | Ruby     | Code intelligence and analysis for `.rb`, `.rake`, `.erb`.                          |
| **rust-analyzer-lsp** | Rust     | Code intelligence and analysis for `.rs`.                                           |
| **swift-lsp**         | Swift    | Code intelligence for `.swift`.                                                     |
| **typescript-lsp**    | TS/JS    | Go-to-definition, find references, error checking for `.ts`, `.tsx`, `.js`, `.jsx`. |

### Output Styles

| Plugin                       | Description                                                                                                            |
| ---------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| **explanatory-output-style** | Recreates the deprecated Explanatory output style as a SessionStart hook (adds token cost).                            |
| **learning-output-style**    | Combines unshipped Learning output style with explanatory functionality — interactive learning mode (adds token cost). |

### Playground & Examples

| Plugin             | Description                                                                                                       |
| ------------------ | ----------------------------------------------------------------------------------------------------------------- |
| **example-plugin** | Comprehensive example demonstrating Claude Code extension options: plugins, skills, commands.                     |
| **playground**     | Creates interactive HTML playgrounds — self-contained explorers with live preview and prompt output.              |
| **cwc-makers**     | Onboarding for Code-with-Claude Makers Cardputer kits — auto-flash UIFlow 2.0 firmware + Claude Buddy app bundle. |

### External Integrations

| Plugin            | Description                                                                             |
| ----------------- | --------------------------------------------------------------------------------------- |
| **asana**         | Asana project management integration.                                                   |
| **context7**      | Context7 documentation integration.                                                     |
| **discord**       | Connect a Discord bot to Claude Code via MCP — reply, react, edit messages.             |
| **fakechat**      | Simple UI for testing the channel contract without an external service.                 |
| **firebase**      | Firebase integration.                                                                   |
| **github**        | GitHub integration.                                                                     |
| **gitlab**        | GitLab integration.                                                                     |
| **greptile**      | Connect Greptile AI code review to Claude — view and resolve PR comments from terminal. |
| **imessage**      | Read iMessage history and send replies via AppleScript (macOS only).                    |
| **laravel-boost** | Laravel framework enhancement integration.                                              |
| **linear**        | Linear project management integration.                                                  |
| **playwright**    | Playwright browser automation integration.                                              |
| **serena**        | Serena codebase context integration.                                                    |
| **telegram**      | Connect a Telegram bot to Claude Code via MCP — reply, react, edit messages.            |
| **terraform**     | Terraform infrastructure integration.                                                   |
