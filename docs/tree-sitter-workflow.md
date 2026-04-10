# Tree-sitter Query Development Workflow

This document describes the workflow for developing and validating Tree-sitter queries in `zed-moonbit`.

---

## Why this matters

If you use invalid node types, Zed will fail:

```
Error loading highlights query
Invalid node type "..."
```

Never guess node names.

---

## Prerequisites

You need:

- tree-sitter-cli
- jq
- Python 3.x
- MoonBit tree-sitter grammar

Install:

```
cargo install --locked tree-sitter-cli
```

or

```
npm install -g tree-sitter-cli
```

macOS jq:

```
brew install jq
```

---

## Grammar version

Check `extension.toml`:

```
rev = "82237f3f508d09fb09668d9885c99a562a756fe0"
```

Always match this version.

---

## Workflow

1. Inspect node types
2. Inspect AST
3. Write minimal queries
4. Validate
5. Only then open Zed

---

## Clone grammar

```
git clone https://github.com/moonbitlang/tree-sitter-moonbit
cd tree-sitter-moonbit
git checkout 82237f3f508d09fb09668d9885c99a562a756fe0
```

---

## Inspect node types

```
jq -r '.[].type' src/node-types.json | sort -u
```

Filter:

```
jq -r '.[].type' src/node-types.json | grep literal
jq -r '.[].type' src/node-types.json | grep definition
```

Rule:

If it's not in node-types.json → don't use it.

---

## Inspect AST

```
tree-sitter parse file.mbt
```

Wrong:

```
(function_item) @item
```

Correct:

```
(function_definition) @item
```

---

## Minimal queries

Start with:

```
(type_identifier) @type
(identifier) @variable
(integer_literal) @number
(string_literal) @string
(comment) @comment
```

---

## Validate queries

Setup:

```
make grammar-setup
```

or

```
just grammar-setup
```

Validate:

```
make validate-queries
```

or

```
just validate-queries
```

---

## Logs

Path:

```
just zed-log-path
```

Tail:

```
just zed-log
```

---

## Dev command

```
just dev
```

or

```
make dev
```

---

## Windows

```
pwsh -File scripts/dev.ps1
```

Logs:

```
python scripts/zed_log.py --tail
```

---

## Safe patterns

```
(identifier)
(type_identifier)
(integer_literal)
(comment)
```

---

## Dangerous patterns

```
(number_literal)
(primitive_type)
(function_item)
```

---

## Outline baseline

```
(function_definition)
(struct_definition)
(enum_definition)
(trait_definition)
(impl_definition)
```

---

## Indents baseline

```
(block_expression)
(array_expression)
(tuple_expression)
```

---

## Rules

- never guess node names
- validate before testing
- keep queries minimal
- fix errors immediately

---

## Dev commands summary

macOS/Linux:

```
just dev
just zed-log # via a secondary terminal window/panel
```

Make:

```
make dev
make zed-log # via a secondary terminal window/panel
```

Windows:

```
pwsh -File scripts/dev.ps1
python scripts/zed_log.py --tail # via a secondary terminal window/panel
```

---

## Publish-ready checklist

- no invalid queries
- grammar pinned
- clean README
- working LSP
- tested on real files
- versioned (SemVer)

---

## Final principle

A simple valid query > complex broken query.