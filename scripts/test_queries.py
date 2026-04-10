#!/usr/bin/env python3

import subprocess
import sys
from pathlib import Path

TEST_FILES_DIR = Path("tests")

def run_parse(file_path):
    try:
        subprocess.run(
            ["tree-sitter", "parse", str(file_path)],
            check=True,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL
        )
        return True
    except subprocess.CalledProcessError:
        return False

def main():
    if not TEST_FILES_DIR.exists():
        print("No tests directory found.")
        return 0

    failures = 0

    for file in TEST_FILES_DIR.glob("*.mbt"):
        ok = run_parse(file)
        if not ok:
            print(f"Failed parsing: {file}")
            failures += 1

    if failures > 0:
        print(f"{failures} parsing failures")
        return 1

    print("All test files parsed successfully")
    return 0

if __name__ == "__main__":
    sys.exit(main())