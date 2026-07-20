---
name: code-style
description: Loads the correct code style guide for the active language. Trigger automatically whenever writing, reviewing, or refactoring code in Bash, C++, C#, Dart, HTML/CSS, JavaScript, Kotlin, Markdown, Python, or TypeScript — even if the user doesn't ask for it explicitly. Infer the language from file extensions, imports, or syntax in context. Do not ask the user which guide to load.
---

# Code Style

Load and silently apply the style guide for the active language.

## Language Detection

Infer from context — in order of priority:

1. File extension (`.js` `.ts` `.py` `.html` `.css` `.md` `.kt` `.dart` `.cs` `.cpp` `.sh`)
2. Imports or syntax visible in the conversation
3. Explicit user mention

If multiple languages are active (e.g. TypeScript + HTML/CSS), load all relevant guides.

## Style Guides

| Language   | Reference file               |
| ---------- | ---------------------------- |
| Bash       | `./references/bash.md`       |
| C++        | `./references/cpp.md`        |
| C#         | `./references/csharp.md`     |
| Dart       | `./references/dart.md`       |
| HTML / CSS | `./references/html-css.md`   |
| JavaScript | `./references/javascript.md` |
| Kotlin     | `./references/kotlin.md`     |
| Markdown   | `./references/markdown.md`   |
| Python     | `./references/python.md`     |
| TypeScript | `./references/typescript.md` |

Read only the guide(s) needed. Apply conventions silently — do not announce which guide was loaded unless the user asks.
