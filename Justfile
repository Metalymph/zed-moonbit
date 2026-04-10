set shell := ["bash", "-cu"]

tree_sitter_dir := env("TREE_SITTER_DIR", "../tree-sitter-moonbit")
grammar_commit := env("GRAMMAR_COMMIT", "82237f3f508d09fb09668d9885c99a562a756fe0")
node_types := tree_sitter_dir + "/src/node-types.json"
python := if os() == "windows" { "python" } else { "python3" }

help:
  echo "Available recipes:"
  echo "  just help                Show this help message"
  echo "  just grammar-setup       Clone/update the MoonBit grammar locally"
  echo "  just clean-grammar       Remove the local MoonBit grammar checkout"
  echo "  just grammar-check       Check that the pinned grammar exists"
  echo "  just validate-queries    Run all query validation checks"
  echo "  just zed-log-path        Print the expected Zed log path"
  echo "  just zed-log             Tail Zed.log"
  echo "  just dev                 Validate queries and open the project in Zed"

default:
  just help

grammar-setup:
  #!/usr/bin/env bash
  if [ ! -d "{{tree_sitter_dir}}" ]; then
    git clone https://github.com/moonbitlang/tree-sitter-moonbit "{{tree_sitter_dir}}"
  fi
  cd "{{tree_sitter_dir}}"
  git fetch --all --tags --prune
  git checkout "{{grammar_commit}}"

grammar-check:
  #!/usr/bin/env bash
  if [ ! -f "{{node_types}}" ]; then
    echo "Missing {{node_types}}"
    echo "Run: just grammar-setup"
    exit 1
  fi
  echo "Grammar node-types found: {{node_types}}"

clean-grammar:
  #!/usr/bin/env bash
  if [ -d "{{tree_sitter_dir}}" ]; then
    echo "Removing Tree-sitter MoonBit grammar at {{tree_sitter_dir}}"
    rm -rf "{{tree_sitter_dir}}"
  else
    echo "No grammar directory found at {{tree_sitter_dir}}"
  fi

validate-queries: grammar-check
  {{python}} scripts/validate_queries.py "{{node_types}}" \
    languages/moonbit/highlights.scm \
    languages/moonbit/outline.scm \
    languages/moonbit/indents.scm \
    languages/moonbit/brackets.scm \
    languages/moonbit/injections.scm

zed-log-path:
  {{python}} scripts/zed_log.py --print-path

zed-log:
  {{python}} scripts/zed_log.py --tail

dev:
  {{python}} scripts/dev.py