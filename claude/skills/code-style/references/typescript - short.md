# TypeScript Style Guide

You are an expert TypeScript developer strictly adhering to the Google TypeScript Style Guide. When writing, reviewing, or refactoring TypeScript code, apply the following rules. These are the most important and frequently applicable guidelines; when in doubt, prefer consistency with existing code in the same file or project.

---

## 1. Source File Basics

### File Encoding & Whitespace

- Source files must be **UTF‑8** encoded.
- Only the ASCII horizontal space (0x20) is allowed as whitespace outside string literals. Other whitespace characters must be escaped.
- **Special escape sequences** (`\'`, `\"`, `\\`, `\b`, `\f`, `\n`, `\r`, `\t`, `\v`) are preferred over numeric escapes. Never use octal escapes.
- Use actual Unicode characters for non‑ASCII characters (e.g., `π`) instead of escapes, unless the character is non‑printable.

### Source File Structure (in order)

1. Copyright/license information (JSDoc) – if present.
2. `@fileoverview` JSDoc – if present.
3. Imports – if present.
4. Implementation.

Separate each section with exactly one blank line.

### Imports

- Use **ES6 module syntax** (`import ... from ...`). Do **not** use `require` or `import x = require(...)`.

- **Import paths**:
  
  - Prefer **relative imports** (`./foo`) over absolute imports for files within the same logical project. Limit excessive `../` steps.

- **Import types**:
  
  - Use **namespace imports** (`import * as foo from '...'`) for large APIs or when symbols have common names.
  - Use **named imports** (`import {SomeThing} from '...'`) for frequently used symbols with clear names.
  - Use **default imports** (`import SomeThing from '...'`) only for external code that requires them (e.g., some legacy libraries).
  - Use **side‑effect imports** (`import '...'`) only for libraries that need to run on load.

- **Renaming imports** is allowed to avoid collisions or improve clarity (e.g., `import {from as observableFrom} from 'rxjs'`).

- For **Apps JSPB protos**, use named imports even if lengthy.

- **Always use `import type`** when importing a symbol only as a type. This aids `isolatedModules` and speeds up development builds. Example:
  
  ```typescript
  import type {Foo} from './foo';
  import {Bar} from './foo'; // value
  // or combined:
  import {type Foo, Bar} from './foo';
  ```

### Exports

- **Use named exports** exclusively. **Do not use default exports**.
  
  - Named exports prevent accidental mis-imports and make refactoring easier.

- **Export only symbols used outside the module**. Keep the exported API surface minimal.

- **Mutable exports are forbidden** – do not use `export let`. If you need externally accessible mutable state, provide a getter function.
  
  ```typescript
  let foo = 3;
  export function getFoo() { return foo; }
  ```

- **When conditionally exporting**, perform the check before the export and ensure all exports are final after module execution.

- **Avoid container classes** with static methods/properties for namespacing. Export individual constants and functions instead.

- **Use `export type`** when re‑exporting a type:
  
  ```typescript
  export type {AnInterface} from './foo';
  ```

### Namespaces & Modules

- **Do not use `namespace`** (or the older `module` keyword). Use ES6 modules for all code organisation.
- **Do not use `/// <reference path="..."/>`** comments.

---

## 2. Language Features

### Variable Declarations

- Always use `const` or `let`. Never use `var`.
- Prefer `const` by default; use `let` only when reassignment is needed.
- **One variable per declaration** – do not use comma‑separated declarations (e.g., `let a = 1, b = 2;`).
- Variables must not be used before declaration.

### Array Literals

- **Do not use the `Array` constructor** (`new Array()`). Use bracket notation or `Array.from`.

- **Do not define non‑numeric properties on arrays** – use `Map` or `Object` for that.

- **Spread syntax** is allowed for shallow copying/concatenating. The spread value must match the target (spread only iterables into arrays, only objects into objects). Do not spread primitives, `null`, or `undefined`.

- **Array destructuring** is allowed; use `[]` as default for optional destructured parameters.
  
  ```typescript
  function destructured([a = 4, b = 2] = []) { … }
  ```

- Prefer object destructuring over array destructuring when the values have meaningful names.

### Object Literals

- **Do not use the `Object` constructor** – use `{}` or `{a: 0, b: 1}`.
- **Iterating objects**: never use unfiltered `for...in` because it includes prototype properties. Use `for...of` with `Object.keys()`, `Object.values()`, or `Object.entries()`, or explicitly check `hasOwnProperty`.
- **Spread syntax** for objects is allowed; only spread plain objects (not arrays, primitives, or class instances). Later properties override earlier ones.
- **Computed property names** are allowed, but they are treated as quoted/dict‑style keys (unless they are symbols). Do not mix quoted and unquoted keys in the same object.
- **Object destructuring** is encouraged for unpacking multiple values. Keep parameter destructuring simple – one level of unquoted shorthand properties, default values on the left (`{str = 'default'} = {}`), and the whole object defaults to `{}` if optional.

### Classes

- **Class declarations must not end with a semicolon**.

- **Method declarations** must not use semicolons between methods. Separate methods with a single blank line.

- **`toString`** may be overridden, but must be side‑effect‑free and always succeed.

- **Static methods**:
  
  - Prefer module‑local functions over private static methods when possible.
  - Do not rely on dynamic dispatch of static methods. Call them only on the base class that defines them.
  - Do **not** use `this` in static methods (it leads to surprising inheritance behaviour).

- **Constructors**:
  
  - Always use parentheses when calling `new` – `new Foo()` not `new Foo`.
  - Do not provide an empty constructor or one that only calls `super()` unless parameter properties, visibility modifiers, or decorators are needed.
  - Separate constructor with a blank line above and below.

- **Class members**:
  
  - **Do not use `#private` fields** – they cause performance and down‑level issues. Use TypeScript `private` visibility.
  
  - Mark properties that are never reassigned outside the constructor with `readonly`.
  
  - Use **parameter properties** to shorten constructors:
    
    ```typescript
    class Foo {
      constructor(private readonly barService: BarService) {}
    }
    ```
  
  - Initialize fields where they are declared when possible.
  
  - Properties used outside the class's lexical scope (e.g., Angular templates) must **not** be `private` – use `protected` or `public`.
  
  - Do not bypass visibility with `obj['foo']`.
  
  - **Getters and setters**:
    
    - Getters must be pure (no observable side effects).
    - At least one accessor must be non‑trivial. Do not write pass‑through getters/setters – make the property public.
    - Do not use `Object.defineProperty` for accessors.
  
  - **Computed properties** may only be used for `Symbol` keys.
  
  - **Visibility**: Omit the `public` modifier (it is the default). Use `private` or `protected` when needed. Use `readonly` for public properties that shouldn't be reassigned.

### Functions

- **Prefer function declarations** for named top‑level functions, not arrow functions or function expressions.
- **Nested functions** may use declarations or arrow functions; arrow functions are preferred in methods because they capture `this`.
- **Do not use function expressions** – use arrow functions instead. Exception: if you need dynamic `this` rebinding (discouraged) or generator functions (no arrow syntax).
- **Arrow function bodies**:
  - Use concise (expression) bodies only when the return value is actually used; otherwise use block bodies to avoid unintended return values.
  - Use `void` to ensure expression‑body returns `undefined` when unused.
- **Rebinding `this`** is discouraged. Prefer arrow functions over `bind`, `goog.bind`, or `const self = this`.
- **Prefer arrow functions as callbacks** rather than passing named callbacks directly, to avoid unexpected arguments (e.g., `parseInt` with `map`).
- **Arrow functions as class properties** are discouraged; they make `this` binding unclear. Use an arrow function at call site instead. Exception: event handlers that need uninstallation.
- **Parameter initializers** are allowed but must have no side effects. Keep them simple.
- **Prefer rest parameters** (`...args`) over `arguments`. Never name a variable `arguments`.
- **Formatting**: No blank lines at start/end of function body. Generators: `function* foo()` and `yield* iter` (no spaces after `*`). Single‑argument arrow functions may omit parentheses. No space after `...` in rest/spread.

### `this`

- Only use `this` in class constructors/methods, functions with explicit `this` type, or arrow functions defined in a scope where `this` is meaningful.
- Never use `this` to refer to the global object, event target, or with `call`/`apply` unnecessarily.

### Interfaces

- Prefer interfaces over type aliases for object types (see Type System section).

### Primitive Literals

- **Strings**: Use single quotes (`'`) for ordinary strings. Use template literals for complex concatenation or multi‑line strings. Do not use line continuations (backslash at end of line).
- **Numbers**: Use decimal, hex (`0x`), octal (`0o`), binary (`0b`) as appropriate. Lowercase letters for hex. No leading zeros.
- **Type coercion**:
  - Use `String()`, `Boolean()`, `!!`, or template literals as needed.
  - **Do not coerce enum values to boolean** – compare explicitly (e.g., `level !== SupportLevel.NONE`).
  - Use `Number()` to parse strings, and always check for `NaN` with `isFinite`. **Do not use unary `+`** for parsing. **Do not use `parseInt`/`parseFloat`** except for non‑base‑10 strings with explicit radix, and validate input first.
  - Use `Number()` + `Math.floor` or `Math.trunc` for integer parsing.
  - Avoid explicit boolean coercions in `if`, `for`, `while` conditions (they are implicit). Enum values still need explicit comparison.
- **Template literals** may span multiple lines without indent restrictions.

### Control Structures

- Always use braces `{ }` for blocks, even for single statements. Exception: `if` fitting on one line may omit braces.
- **Assignment in control statements** is discouraged; if needed, wrap in extra parentheses to show intent.
- **Iterating containers**:
  - Prefer `for...of` for arrays, or `forEach`, or plain `for` loop with index.
  - Do **not** use `for...in` on arrays (gives string indices).
  - Use `for...in` only on dict‑style objects, with `hasOwnProperty` check.
  - Prefer `for...of` with `Object.keys()`, `Object.values()`, `Object.entries` over `for...in` when possible.
- **Grouping parentheses** – omit only when misinterpretation is impossible.
- **Exception handling**:
  - Always throw `Error` or subclasses (never strings or arbitrary values). Use `new Error()`.
  - Catch blocks should assume caught values are `Error`. Avoid defensive handling of non‑Error types unless explicitly known.
  - Empty `catch` blocks are rarely correct; if used, explain why in a comment.
- **Switch statements**:
  - Always include a `default` case (even if empty), placed last.
  - Each non‑empty case must end with `break`, `return`, or `throw`. Fall‑through is not allowed except for empty cases.
- **Equality checks**:
  - Always use `===` and `!==`. Exception: `== null` is allowed to check for both `null` and `undefined`.

### Type Assertions

- Avoid type assertions (`as Foo`) and non‑null assertions (`!`) unless unavoidable. When used, add a comment explaining why it's safe.
- Use `as` syntax, not angle‑brackets (`<Foo>x`).
- If a double assertion is needed, use `as unknown as Foo` (not `as any`).
- **Prefer type annotations** (`: Foo`) over type assertions for object literals, so that extra properties are caught.

### Decorators

- **Do not define new decorators** – only use those from frameworks (Angular, Polymer). Decorators are experimental and have known issues.
- Place decorators immediately before the symbol, with no empty lines between. JSDoc goes before the decorator.

### Disallowed Features

- **Wrapper objects** (`new String()`, `new Boolean()`, `new Number()`) – disallowed. Use primitive types.
- **Do not rely on Automatic Semicolon Insertion** – always end statements with `;`.
- **`const enum`** – disallowed; use plain `enum`.
- **`debugger`** – disallowed in production code.
- **`with`** – disallowed.
- **`eval` and `Function` constructor** – disallowed (except code loaders).
- **Non‑standard ECMAScript/Web features** – avoid deprecated, non‑standard, or unratified proposals.
- **Modifying builtin objects** – never add to prototypes or global objects.

---

## 3. Naming

### General

- Identifiers use only ASCII letters, digits, underscores (in constants and test names), and rarely `$`.
- Names must be descriptive; avoid abbreviations unless very common (DNS, URL, Id).
- Do **not** decorate names with type information (no Hungarian notation, no `_` prefix/suffix, no `I` for interfaces, no `opt_`).
- Treat acronyms as whole words: `loadHttpUrl`, not `loadHTTPURL` (unless platform requires: `XMLHttpRequest`).
- `$` may be used for Observable naming convention (e.g., `users$`) if team agrees.

### Casing by Identifier Type

| Style                         | Category                                                                 |
| ----------------------------- | ------------------------------------------------------------------------ |
| `UpperCamelCase`/`PascalCase` | class, interface, type, enum, decorator, type parameters, TSX components |
| `lowerCamelCase`              | variable, parameter, function, method, property, module alias            |
| `CONSTANT_CASE`               | global constants (module‑level `const`, `static readonly`), enum values  |
| `#ident`                      | never used (private identifiers disallowed)                              |

- **Type parameters** may be single uppercase (`T`) or `UpperCamelCase`.
- **Test method names** may use underscores (`testX_whenY_doesZ`).
- **No `_` prefix/suffix** – not even to mark unused parameters. Use destructuring with commas to skip array elements.
- **Imports**: module namespace aliases are `lowerCamelCase`, even if the file is `snake_case` (e.g., `import * as fooBar from './foo_bar';`). Exception: well‑known libraries like `$` (jQuery) or `THREE` (threejs).
- **Constants**: Use `CONSTANT_CASE` for module‑level constants, static readonly fields, and enum values. Local constants (inside functions) use `lowerCamelCase`.

### Aliases

- Local aliases should match the original symbol's name and casing.
- Use `const` for aliases (or `readonly` in classes).

---

## 4. Type System

### Type Inference

- Rely on type inference for simple cases (literal initializations).
- Explicit annotations may be needed for generic types when inference would be `unknown` (e.g., `new Set<string>()`).
- Annotations are optional; reviewers may ask for them when types are not obvious.
- **Return types**: Optional; can be added to improve documentation and catch future changes.

### `undefined` and `null`

- Use either `undefined` or `null` as appropriate for the API (e.g., `Map.get` uses `undefined`, DOM uses `null`).
- **Do not create type aliases that include `|null` or `|undefined`** – add these unions only where the value is actually used. Handle null/undefined close to the source.
- Prefer **optional fields/parameters** (`?`) over `|undefined` in types.

### Structural Types

- TypeScript is structural: a value matches a type if it has the required properties.
- Explicitly annotate objects with their interface/type at declaration to catch errors early.
- Use **interfaces** to define structural types, not classes.

### Prefer Interfaces over Type Aliases for Objects

- Use `interface` for object types; avoid `type` for object literals. Type aliases are fine for primitives, unions, tuples, etc.

### `Array<T>` Syntax

- For simple types, use `T[]` and `readonly T[]`; for complex types (union, nested generics, etc.), use `Array<T>` and `ReadonlyArray<T>`.
- Multi‑dimensional arrays: `T[][]` for simple types.

### Index Signatures

- Use `{[key: string]: T}` with a meaningful key label (e.g., `[userName: string]: number`). Consider using `Map` or `Set` instead of plain objects for maps.

### Mapped & Conditional Types

- Use the simplest construct. Avoid complex type operators unless they significantly reduce duplication. Prefer explicit interfaces over `Pick` or `Omit` when readability matters.

### `any` Type

- **Avoid `any`**. Use `unknown` for truly unknown types, then narrow with type guards.
- If `any` is necessary (e.g., mocks), suppress the lint warning with a comment explaining why.
- Prefer providing a specific interface or generic type.

### `{}` Type

- Avoid `{}` (empty interface) – it allows any non‑nullish value. Use `unknown`, `Record<string, T>`, or `object` as appropriate.

### Tuple Types

- Use tuples `[string, string]` for simple pairs, but prefer object types with named fields for clarity.

### Wrapper Types

- Never use `String`, `Boolean`, `Number` – use `string`, `boolean`, `number`.
- Avoid `Object` – use `{}` or `object`.

### Return‑Type‑Only Generics

- Avoid creating APIs with generics only in the return type. When calling such APIs, explicitly specify the generic type.

---

## 5. Comments & Documentation

### JSDoc vs Ordinary Comments

- Use `/** JSDoc */` for **documentation** (intended for API users).
- Use `// line comments` for **implementation comments** (intended for maintainers).
- Multi‑line comments should use `//` for each line, not `/* */`.

### JSDoc Formatting

- Basic form:
  
  ```typescript
  /**
   * Multiple lines of text, wrapped.
   * @param arg Description.
   */
  function doSomething(arg: number) { … }
  ```

- Single‑line form allowed if it fits: `/** Short description. */`.

- Use Markdown; use lists for items; no boxes.

- Tags must be on their own lines: `@param`, `@return`. Do not combine.

- When wrapping, indent continuation lines 4 spaces.

### What to Document

- **All top‑level exports** should have JSDoc.
- **Classes**: describe purpose and usage; constructor comments are optional.
- **Methods and functions**: describe behaviour; omit obvious parameter/return descriptions.
- **Parameter properties**: document with `@param` JSDoc.
- Do **not** repeat type annotations in JSDoc (`@param {number} arg` is redundant; TypeScript already has types).
- **Deprecation**: mark with `@deprecated` and provide migration directions.
- **Parameter‑name comments** at call sites: use `/* paramName= */` before the value (or legacy after‑value style if file is consistent). Refactor to object destructuring if many parameters.

### Placement

- Place JSDoc **before** decorators, not between decorator and decorated item.

---

## 6. Policies & Toolchain

### Consistency

- Follow existing style in the same file/directory if not covered by this guide.
- New files must be in Google Style. When adding to a non‑compliant file, consider reformatting first (separate CL).

### Reformatting Existing Code

- Do not reformat just for style; only when making significant changes.
- Separate large style fixes into their own CL.

### Compiler & Linting

- All TypeScript code must pass type checking with the standard compiler flags.
- **Do not use `@ts-ignore`, `@ts-expect-error`, or `@ts-nocheck`**. Suppress errors properly (e.g., with `any` and a comment).
- Adhere to conformance rules (tsetse, tsec) when enforced.

### Generated Code

- Generally exempt from style rules, but any identifiers referenced from hand‑written code must follow naming conventions.

---

**Remember**: This guide aims to improve code quality, maintainability, and consistency. When in doubt, use your best judgment and prefer simplicity. If a rule seems unnecessarily restrictive, discuss it with your team.
