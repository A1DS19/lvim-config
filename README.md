### LVim config
#### Install formatters
- cargo install stylua
- rustup component add rustfmt
- sudo apt install clang-format
- pip install black 
- ~~dotnet tool install -g csharpier~~ (C# support removed)
- npm install eslint prettier eslint-config-prettier eslint-plugin-prettier --save-dev (for projects not global)

#### Supported Languages & Tools
**With full LSP support:**
- **Rust** - rust_analyzer + rustfmt
- **C/C++** - clangd + clang-format  
- **TypeScript/JavaScript** - tsserver + eslint + prettier
- **Python** - pyright + black + isort
- **HTML/CSS** - html + cssls + prettier
- **Tailwind CSS** - tailwindcss
- **JSON/YAML** - jsonls + yamlls + prettier
- **Lua** - lua_ls + stylua
- **Bash** - bashls + shfmt
- **Docker** - dockerls
- **Markdown** - marksman + prettier
- **TOML** - taplo
- **CMake** - cmake + cmake-format

**With syntax highlighting only:**
- **C#** - Treesitter syntax highlighting (no LSP/IntelliSense)

#### Additional Features
- **Git integration** - LazyGit
- **File explorer** - nvim-tree
- **Fuzzy finder** - Telescope with file browser
- **Debugging** - nvim-dap + dapui
- **Autocompletion** - nvim-cmp with LSP sources
- **Snippets** - LuaSnip with friendly-snippets
- **Session persistence** - persistence.nvim
- **Theme** - Dracula

#### Notes
- C# language server support has been completely removed
- For C# development, consider using a different editor or manually configuring OmniSharp
- All other languages have full LSP support with formatting, linting, and IntelliSense
