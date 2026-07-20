# Agent Behaviour Guidelines

Behavioral guidelines to reduce common LLM coding mistakes, derived from [Andrej Karpathy's observations](https://x.com/karpathy/status/2015883857489522876) on LLM coding pitfalls.

**Tradeoff:** These guidelines bias toward caution over speed. For trivial tasks, use judgment.

## 0. Hard Rules — Do Not Violate

These are not preferences. They are constraints that prevent wasted turns.

### Shell selection on Windows

**Default tool for system commands: `PowerShell`.** Use it for anything Windows-specific or general system operations.

**Use `Bash` only for these categories:**

- **Text processing:** `sed`, `awk`, `grep`, `tr`, `cut`, `sort`, `uniq`
- **File comparison:** `diff`, `patch`
- **Archiving:** `tar`, `gzip`, `gunzip`
- **Encoding/checksums:** `base64`, `md5sum`, `sha256sum`
- **Network utilities:** `curl`, `wget`
- **Basic I/O:** `cat`, `echo`, `ls`, `wc`, `head`, `tail`, `find`

### NEVER

- **NEVER:** Use Bash as a fallback when PowerShell fails. If a command fails in PowerShell, switch approach or ask the user.
- **NEVER:** Wrap `powershell -Command` inside a Bash tool call. Use the PowerShell tool directly.
- **NEVER:** Assume Linux commands exist on Windows (`chmod`, `chown`, `systemctl`, `df`, `lsof`, `apt`, `yum` — none of these work).

### Operations reference — which shell to use

| Category               | Examples                                                | Tool                       | Notes                                                                                       |
| ---------------------- | ------------------------------------------------------- | -------------------------- | ------------------------------------------------------------------------------------------- |
| **Registry**           | Read/write registry keys                                | `PowerShell`               | `Get-ItemProperty HKLM:\...` / `Set-ItemProperty`. No native Bash equivalent                |
| **Environment vars**   | `$env:PATH`, etc.                                       | `PowerShell`               | Bash cannot read Windows env vars reliably - (`$env:`, `$HOME`) breaks or requires escaping |
| **Processes**          | `Get-Process`, `Stop-Process`, `Start-Process`          | `PowerShell`               | Also `taskkill` via PowerShell, not Bash                                                    |
| **Services**           | `Get-Service`, `Start-Service`, `Stop-Service`          | `PowerShell`               | No `systemctl` on Windows                                                                   |
| **Symlinks**           | `New-Item -ItemType SymbolicLink`                       | `PowerShell`               | Requires admin on most paths; no `ln` command                                               |
| **Permissions/ACLs**   | `icacls`, `Get-Acl`, `Set-Acl`                          | `PowerShell`               | No `chmod`/`chown` — Windows uses ACLs, not Unix perms                                      |
| **Network state**      | `Get-NetTCPConnection`, `Test-NetConnection`, `netstat` | `PowerShell`               | No `ss`, `lsof` on Windows                                                                  |
| **Disk/volumes**       | `Get-Volume`, `fsutil`                                  | `PowerShell`               | No `df`, `lsblk`, `fdisk` on Windows                                                        |
| **User/session**       | `quser`, `logoff`, `whoami`                             | `PowerShell`               | No `logout` on Windows                                                                      |
| **Package management** | `winget`, `scoop`, `choco`                              | `PowerShell`               | No `apt`, `yum`, `dnf` on Windows                                                           |
| **Text processing**    | `sed`, `awk`, `grep`, `tr`, `cut`                       | `Bash`                     | Native POSIX tools via Git Bash (MSYS2)                                                     |
| **File comparison**    | `diff`, `patch`                                         | `Bash`                     | No native PowerShell equivalent for quick diffs                                             |
| **Archiving**          | `tar`, `gzip`                                           | `Bash`                     | `Compress-Archive` exists but is slower and less flexible                                   |
| **Encoding/checksums** | `base64`, `md5sum`, `sha256sum`                         | `Bash`                     | PowerShell alternatives are verbose                                                         |
| **HTTP requests**      | `curl`, `wget`                                          | `Bash`                     | PowerShell has `Invoke-RestMethod` but curl is more familiar                                |
| **File system ops**    | List, recurse, filter files                             | `PowerShell` or Glob/Grep  | `Get-ChildItem` via PowerShell; prefer Glob/Grep for simple searches                        |
| **JSON processing**    | Parse, transform JSON                                   | Write tool or `PowerShell` | `ConvertFrom-Json` / `ConvertTo-Json`; no `jq` installed                                    |
| **File creation**      | Write new/overwrite files                               | Write tool                 | Not Bash redirections (`>`, `>>`) or heredocs                                               |

### Tool limits

- `Glob` and `Grep` are **project-scoped** — they only search within the current working directory. They cannot reach outside (e.g., `~/.claude/`, global skills).
- If a tool fails after one attempt, switch approach or ask — don't chain workarounds.

### When in doubt

Default to `PowerShell`. Only reach for `Bash` if the operation matches an allowed category above. If neither approach is obvious, ask — better to clarify once than waste two turns on the wrong tool.

---

## 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:

- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

## 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.
- Do not add demonstration scripts, debug files, or extraneous modules; only modify production code and, when appropriate, existing tests relevant to the change.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

Make the smallest, most localized change that addresses the issue; modify the correct layer/entry-point (method/class) where the behavior is defined rather than adding wrappers or unrelated helpers.

When editing existing code:

- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:

- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

## 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:

- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:

```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.
