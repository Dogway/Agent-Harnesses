# Google Python Style Guide (Condensed)

This is a condensed version of the Google Python Style Guide. For full details, see the [original](https://google.github.io/styleguide/pyguide.html).

## Table of Contents

1. [Background](#1-background)
2. [Python Language Rules](#2-python-language-rules)
   - 2.1 Lint
   - 2.2 Imports
   - 2.3 Packages
   - 2.4 Exceptions
   - 2.5 Mutable Global State
   - 2.6 Nested Functions/Classes
   - 2.7 Comprehensions
   - 2.8 Default Iterators
   - 2.9 Generators
   - 2.10 Lambda
   - 2.11 Conditional Expressions
   - 2.12 Default Arguments
   - 2.13 Properties
   - 2.14 True/False Evaluation
   - 2.15 Lexical Scoping
   - 2.16 Decorators
   - 2.17 Threading
   - 2.18 Power Features
   - 2.19 `__future__` imports
   - 2.20 Type Annotations
3. [Python Style Rules](#3-python-style-rules)
   - 3.1 Semicolons
   - 3.2 Line Length
   - 3.3 Parentheses
   - 3.4 Indentation
   - 3.5 Blank Lines
   - 3.6 Whitespace
   - 3.7 Shebang
   - 3.8 Comments & Docstrings
   - 3.9 Strings
   - 3.10 Logging & Error Messages
   - 3.11 Files/Sockets
   - 3.12 TODO Comments
   - 3.13 Imports Formatting
   - 3.14 Statements
   - 3.15 Accessors
   - 3.16 Naming
   - 3.17 Main
   - 3.18 Function Length
   - 3.19 Type Annotations Details
4. [Parting Words](#4-parting-words)

---

## 1 Background

- Python is the main dynamic language at Google.
- Use `pylint` (with provided pylintrc) and auto‑formatters (Black or Pyink) to avoid style debates.

---

## 2 Python Language Rules

### 2.1 Lint

- Run `pylint`; suppress warnings with `# pylint: disable=name` and an explanation.
- Prefer `pylint: disable` over `disable-msg`.
- Delete unused arguments with `del` and comment "Unused.".

### 2.2 Imports

- Use `import x` for packages/modules; `from x import y` for modules; `from x import y as z` for aliasing.
- Do not use relative imports; use full package names.
- Exemptions: `typing`, `collections.abc`, `typing_extensions`, `six.moves`.

### 2.3 Packages

- Import each module by its full pathname. Avoid assuming local files are in `sys.path`.

### 2.4 Exceptions

- Use built‑in exceptions when appropriate. Raise `ValueError` for programming errors.
- Do **not** use `assert` for validation that must happen; `assert` may be stripped.
- Custom exceptions: inherit from an existing exception, name ends with `Error`.
- Never use bare `except:` or catch `Exception` unless re‑raising or isolating a thread.
- Keep `try` blocks small; use `finally` for cleanup.

### 2.5 Mutable Global State

- Avoid mutable globals. If necessary, make them internal (`_` prefix) and provide public accessor functions.
- Module‑level constants are allowed; use `CAPS_WITH_UNDER`.

### 2.6 Nested/Local/Inner Classes and Functions

- Allowed when closing over local variables. Avoid hiding from tests; prefix with `_` at module level instead.

### 2.7 Comprehensions & Generator Expressions

- Allowed for simple cases. Do not use multiple `for` clauses or filter expressions if they hurt readability.
- Keep them clear; avoid overly complex comprehensions.

### 2.8 Default Iterators and Operators

- Use default iterators and `in`/`not in` for containers (lists, dicts, files) – e.g., `for key in adict`, `if obj in alist`.
- Do not call `.keys()` or `.readlines()` explicitly unless needed.

### 2.9 Generators

- Use generators when appropriate. In docstrings use `Yields:` instead of `Returns:`.
- Clean up resources by wrapping with a context manager (PEP‑533).

### 2.10 Lambda Functions

- Allowed for one‑liners. For longer logic, use a nested function.
- Prefer `operator` functions over lambdas (e.g., `operator.mul`).

### 2.11 Conditional Expressions

- Allowed for simple cases: `x = 1 if cond else 2`. Each part must fit on one line.
- For complex logic use a full `if` statement.

### 2.12 Default Argument Values

- Allowed, but never use mutable defaults (e.g., `[]`, `{}`, `time.time()`). Use `None` and then create mutable inside.
- With type annotations, use spaces around `=` for defaults (e.g., `a: int = 0`).

### 2.13 Properties

- Use `@property` when getting/setting requires trivial computation or logic.
- Must be cheap, straightforward, and unsurprising. Do not use for simple get/set of an internal attribute (make it public instead).
- Avoid inheriting properties that subclasses might want to override.

### 2.14 True/False Evaluations

- Use implicit false: `if foo:` not `if len(foo) == 0:`.
- Always check for `None` with `is None` / `is not None`.
- Do not compare booleans with `== False`; use `if not x`.
- For sequences, use `if seq:` and `if not seq:`.
- For integers, compare to 0 explicitly if needed (e.g., `if i % 10 == 0`).
- Numpy arrays: use `.size` to test emptiness.

### 2.15 Lexical Scoping

- Allowed. Be aware that assigning to a name makes it local to the current scope.

### 2.16 Decorators

- Use when clearly advantageous. Document that it is a decorator; write unit tests.
- Avoid external dependencies in decorator (files, sockets, etc.) as they run at import time.
- Never use `staticmethod` – write a module‑level function instead.
- Use `classmethod` only for named constructors or class‑specific state updates.

### 2.17 Threading

- Do not rely on atomicity of built‑in types. Use `queue.Queue` for communication, or `threading` primitives.

### 2.18 Power Features

- Avoid custom metaclasses, bytecode hacks, dynamic inheritance, `__del__`, etc. Use standard library classes that use them (e.g., `abc`, `dataclasses`, `enum`) instead.

### 2.19 `from __future__` imports

- Encourage use to enable modern syntax. Keep them until you drop support for older Python.
- Example: `from __future__ import generator_stop` for Python <3.7.

### 2.20 Type Annotations

- Strongly encouraged for public APIs and code that is stable.
- Use type checkers (pytype) at build time. Use `Any` when type is not expressible.
- Annotate `self`/`cls` not required; use `Self` when needed.
- No need to annotate `__init__` return.
- For imports, import symbols directly from `typing` and `collections.abc` (e.g., `from collections.abc import Sequence`).

---

## 3 Python Style Rules

### 3.1 Semicolons

- Do not use.

### 3.2 Line Length

- Maximum **80 characters**.
- Exceptions: imports, URLs/pathnames in comments, long module‑level constants, pylint disable comments.
- Do **not** use backslashes for line continuation; use parentheses/brackets/braces implicit joining.
- Break at highest syntactic level.

### 3.3 Parentheses

- Use sparingly. Not required for return or conditional statements unless line continuation or tuple indication.

### 3.4 Indentation

- **4 spaces**; no tabs.
- Align wrapped elements vertically, or use hanging 4‑space indent.
- Trailing commas recommended when closing bracket is on a new line, and for single‑element tuples.

### 3.5 Blank Lines

- Two blank lines between top‑level definitions (functions/classes).
- One blank line between method definitions and between class docstring and first method.
- No blank line after `def`.

### 3.6 Whitespace

- No spaces inside parentheses, brackets, or braces.
- No space before comma, semicolon, colon; space after them (except end of line).
- No space before open paren/bracket for function calls or indexing.
- No trailing whitespace.
- Surround binary operators with single space (`=`, comparisons, booleans). For arithmetic, use judgment.
- For keyword/default arguments with type annotation, use spaces around `=` (e.g., `def f(a: int = 0)`); otherwise no spaces.
- Do not vertically align tokens (maintenance burden).

### 3.7 Shebang Line

- Only for executable main files: `#!/usr/bin/env python3` or `#!/usr/bin/python3`.

### 3.8 Comments and Docstrings

- Use `"""` for docstrings.
- **Modules**: docstring describing contents and usage, with license boilerplate.
- **Functions/Methods**: mandatory for public API, nontrivial size, or non‑obvious logic.
  - Structure: summary line, blank line, details.
  - Sections: `Args:`, `Returns:` / `Yields:`, `Raises:` – each with hanging indent.
  - For overridden methods: if decorated with `@override`, docstring optional; otherwise required.
- **Classes**: docstring with `Attributes:` section for public attributes (not properties).
- **Block/Inline comments**: use for tricky logic; place at least 2 spaces from code.
- Pay attention to punctuation, spelling, and grammar.

### 3.9 Strings

- Use f‑strings, `%`, or `.format()` for formatting – avoid `+` for complex formatting.
- Do not use `+=` in loops to accumulate strings; use `''.join(list)` or `io.StringIO`.
- Be consistent with quote style (`'` or `"`) per file; use the opposite to avoid escaping.
- Multi‑line strings: prefer `"""` for docstrings; for other multiline, use `'''` only if project uses `'` for regular strings.
- Use `textwrap.dedent()` to remove leading spaces if needed.

### 3.10 Logging & Error Messages

- **Logging**: pass string literal with `%`‑placeholders as first argument, not f‑strings.
- **Error messages**: be precise, clearly identify interpolated pieces, and make them grep‑able.

### 3.11 Files, Sockets, and Stateful Resources

- Explicitly close them; use `with` statements or `contextlib.closing()`.
- Do not rely on `__del__` for cleanup.

### 3.12 TODO Comments

- Format: `# TODO: bug_link - explanation`.
- Use bug references, not individual names.

### 3.13 Imports Formatting

- One import per line (exception for `typing`/`collections.abc`).
- Group imports:
  1. `__future__`
  2. Standard library
  3. Third‑party
  4. Code repository sub‑packages
  5. (Deprecated) Application‑specific sub‑package imports – new code doesn't need this grouping.
- Sort lexicographically within each group.

### 3.14 Statements

- One statement per line.
- Allowed: `if foo: bar(foo)` only if no `else` and fits on one line.

### 3.15 Accessors (Getters/Setters)

- Use when getting/setting is complex or costly. If trivial, make attribute public.
- Use `get_foo()` / `set_foo()` naming. Do not reuse old property names – break old usage to signal change.

### 3.16 Naming

- `module_name`, `package_name`, `ClassName`, `method_name`, `function_name`, `GLOBAL_CONSTANT_NAME`, `global_var_name`, `instance_var_name`, `function_parameter_name`, `local_var_name`.
- Avoid abbreviations; be descriptive.
- Single‑character names allowed for counters, exceptions (`e`), file handles (`f`), private typevars, and established math notation.
- Do **not** use dashes in package/module names.
- Use `.py` extension.
- Internal names: prefix with `_`; avoid `__` (dunder) mangling – use single underscore.
- **Unit tests**: name `test_<method>_<state>` (PEP 8).
- For class names, use CapWords; for modules, lower_with_under.
- See table for internal vs public naming (constants: `CAPS_WITH_UNDER`, etc.).

### 3.17 Main

- Use `if __name__ == '__main__':` to guard execution. Put main logic in a `main()` function.
- For absl, use `app.run(main)`.

### 3.18 Function Length

- Prefer small functions; no hard limit. If over ~40 lines, consider breaking up.

### 3.19 Type Annotations Details

- **Line breaking**: put each parameter and return type on own line when needed, aligning `)` with `def`.
- **Forward declarations**: use `from __future__ import annotations` or string literals.
- **Default values**: spaces around `=` only when type annotation present.
- **NoneType**: use explicit `X | None` (or `Optional[X]`) – never implicit.
- **Type aliases**: use CapWorded names; mark internal with `_`.
- **Ignoring types**: use `# type: ignore` or `# pytype: disable=...`.
- **Typing variables**: prefer annotated assignments (`a: Foo = ...`) over `# type:` comments (deprecated).
- **Tuples vs Lists**: `list[T]` for homogeneous; `tuple[T, ...]` for repeated; `tuple[T1, T2]` for fixed.
- **Type variables**: use `TypeVar` with descriptive names; `_T` for private unconstrained.
- **String types**: use `str` for text, `bytes` for binary. Avoid `typing.Text`.
- **Imports for typing**: import symbols directly from `typing` and `collections.abc` (e.g., `from collections.abc import Sequence`). Prefer abstract containers (`Sequence`) over concrete (`list`) in annotations.
- **Conditional imports**: use `if TYPE_CHECKING:` only as last resort; reference types as strings.
- **Circular dependencies**: use `Any` alias to break cycles.
- **Generics**: always specify type parameters; `Sequence` alone means `Sequence[Any]`.

---

## 4 Parting Words

*BE CONSISTENT*. Follow the local style of the code you are editing. Global rules are a baseline, but local consistency matters. When new styles emerge, adopt them gradually; do not use old style just for consistency if the new style is better.
