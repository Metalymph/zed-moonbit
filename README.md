# zed-moonbit

`zed-moonbit` is an extension for [Zed Editor](https://zed.dev/) that adds support for the [MoonBit](https://www.moonbitlang.com/) programming language.

## Features
- **Syntax Highlighting**: Initial Tree-sitter queries for readable and explicit code.
- **LSP Integration**: Direct bootstrap of the MoonBit Language Server (`moonbit-lsp`).
- **Outline**: Easy quick navigation for functions, types, and structures.
- **Editor Support**: Bracket matching, autoclose, and indentation for a smooth writing experience.

## Project Status
The extension provides a solid and maintainable base. Currently, the MoonBit Tree-sitter grammar is under constant development; the Tree-sitter queries implemented here might be refined over time and may not cover all constructs, so they will need to be adapted to the actual MoonBit grammar.

## Repository Structure
- `extension.toml`: Extension manifest. Defines name, version, registered language servers, and the Tree-sitter grammar repository.
- `src/lib.rs`: The Rust core of the extension. It looks for `moonbit-lsp` in the PATH and configures its launch.
- `languages/moonbit/config.toml`: Base configuration for MoonBit files in Zed (tab size, line comments, bracket completion).
- `languages/moonbit/*.scm`: Files containing Tree-sitter queries:
  - `highlights.scm`: Defines syntax highlighting rules (keywords, operators, strings, comments).
  - `brackets.scm`: Manages visual matching of brackets `{}`, `[]`, `()`.
  - `outline.scm`: Extracts identifiers and types to populate the editor's "Outline" panel.
  - `indents.scm`: Defines automatic indentation for blocks and function calls.
  - `injections.scm`: File prepared but currently minimal, intended for future grammar injection (e.g., Markdown in doc comments).
- `Cargo.toml`: Rust crate configuration to interact with the Zed environment and APIs.
- `CHANGELOG.md`: Historical track of all relevant changes for the extension versions.
- `CONTRIBUTING.md`: Guidelines on how to participate in development, maintain code style, and propose Pull Requests.

## Prerequisites
- [Zed Editor](https://zed.dev).
- `moonbit-lsp` available in your `PATH`.
- Rust toolchain installed via `rustup` (required for developing Zed extensions).
- (*Optional*) MoonBit toolchain installed on your local system for testing and end-to-end workflows.

## Language Server Installation
To use the full features of the extension (like autocomplete, go to definition, etc.), you must have `moonbit-lsp` installed.

A practical method for installation is via `npm`:
```bash
npm install -g @moonbit/moonbit-lsp
```
> **Note:** Ensure that the installation path where the executable resides is visible to the system `PATH` used by Zed.

## Local Development
1. Clone the repository to your local environment:
   ```bash
   git clone https://github.com/Metalymph/zed-moonbit
   cd zed-moonbit
   ```
2. Install as a Dev Extension in Zed. Based on the current extension development workflow in Zed, open this folder and run the `zed: install dev extension` command from the Command Palette to load the files.
3. If you want to develop the syntax and modify an `*.scm` file, save the changes and perform a "Reload Window" or a recompilation to reflect the rules on opened `*.mbt` files.
4. AST compilation output and any LSP Server logs will be outputted in the dedicated terminal inside the editor.

## Build
The project contains a Rust crate. During local development as a dev extension, Zed automatically handles the necessary compilation of the crate in the background workflow. In most cases, you don't need to run any manual build command. However, Rust is required to be installed.

## Installation in Zed
Although it is optimized as a modular base intended for a future release:
1. Open the Zed command palette.
2. Go to Extensions.
3. Add it locally pointing to the root via `Install Dev Extension`.

## Troubleshooting

- **Binary `moonbit-lsp` not found**
  If the extension reports that the LSP is not in the PATH, it means the scope visible to Zed Editor differs from your standard terminal. Check by opening the integrated terminal in Zed and running `which moonbit-lsp`, and insert the correct target to your `~/.bashrc` or `~/.zshrc`.
- **Incomplete Syntax Highlighting**
  The current queries are initial. If you notice tokens that appear as plain-text, check `highlights.scm` and update it with the appropriate node identifiers based on upstream changes.
- **`.mbt` files processed as plain text**
  This means the editor did not load `config.toml`. Restart the editor so it re-indexes the file-syntax dependencies of the Dev Extension.
- **Tree-sitter Grammar to update**
  Inside the `extension.toml` metafile, you will find a commit pin for the grammar repo. You can move it to a more recent verified revision.

## Roadmap
- Refinement of Tree-sitter queries following upstream modifications.
- Native outline/indent improvements on more complex MoonBit constructs.
- Packaging/Testing for a stable precompiled release in the Zed Extension Store.

## Contributing
See [CONTRIBUTING.md](./CONTRIBUTING.md) for instructions on how to propose your first changes.

## License
Distributed under the [MIT](./LICENSE) license.
