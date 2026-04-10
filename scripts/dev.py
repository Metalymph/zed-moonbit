#!/usr/bin/env python3

from __future__ import annotations

import os
import platform
import subprocess
import sys
from pathlib import Path


GRAMMAR_COMMIT = os.environ.get(
    "GRAMMAR_COMMIT",
    "82237f3f508d09fb09668d9885c99a562a756fe0",
)

TREE_SITTER_DIR = Path(os.environ.get("TREE_SITTER_DIR", "../tree-sitter-moonbit"))
NODE_TYPES = TREE_SITTER_DIR / "src" / "node-types.json"

SCM_FILES = [
    "languages/moonbit/highlights.scm",
    "languages/moonbit/outline.scm",
    "languages/moonbit/indents.scm",
    "languages/moonbit/brackets.scm",
    "languages/moonbit/injections.scm",
]


def run(cmd: list[str], check: bool = True) -> int:
    print("+", " ".join(cmd))
    result = subprocess.run(cmd)
    if check and result.returncode != 0:
        raise SystemExit(result.returncode)
    return result.returncode


def ensure_node_types() -> None:
    if NODE_TYPES.exists():
        return

    print(f"Missing {NODE_TYPES}", file=sys.stderr)
    print("Run grammar setup first.", file=sys.stderr)
    print("Suggested command:", file=sys.stderr)
    print("  just grammar-setup", file=sys.stderr)
    print("or", file=sys.stderr)
    print("  make grammar-setup", file=sys.stderr)
    raise SystemExit(1)


def python_cmd() -> str:
    if platform.system() == "Windows":
        return "python"
    return "python3"


def open_zed(project_dir: Path) -> None:
    try:
        run(["zed", str(project_dir)], check=True)
    except FileNotFoundError:
        print("Could not find `zed` in PATH.", file=sys.stderr)
        print("Open the project manually in Zed.", file=sys.stderr)
        raise SystemExit(1)


def main() -> int:
    project_dir = Path.cwd()

    ensure_node_types()

    print("Validating Tree-sitter queries...")
    run([python_cmd(), "scripts/validate_queries.py", str(NODE_TYPES), *SCM_FILES])

    print("\nZed log path:")
    run([python_cmd(), "scripts/zed_log.py", "--print-path"])

    print("\nOpening project in Zed...")
    open_zed(project_dir)

    print("\nDone.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())