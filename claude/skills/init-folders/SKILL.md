---
name: init-folders
description: Initialize Claude Code project folders deterministically (includes project detection and codegraph initialization)
shell: powershell
author: Jose Linares Churruca
---

1. Run:

```powershell
powershell -ExecutionPolicy Bypass -File "$HOME/.claude/skills/init-folders/init-folders.ps1"
```

This script will:
- Create the .claude directory structure (skills, agents)
- Create default configuration files (settings.json, settings.local.json, .mcp.json, CLAUDE.md, CLAUDE.local.md, .claudeignore)
- Check for common project files (source code, project configs, environment files) in the current directory
- If a coding project is detected, run `codegraph init -i` to initialize the codegraph index
- No further steps are required; the skill is deterministic and self-contained.
