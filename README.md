### LVim config
#### Install formatters
- cargo install stylua
- rustup component add rustfmt
- sudo apt install clang-format
- pip install black 
- dotnet tool install -g csharpier (for C# formatting)
- npm install eslint prettier eslint-config-prettier eslint-plugin-prettier --save-dev (for projects not global)

#### Supported Languages & Tools
**With full LSP support:**
- **Rust** - rust_analyzer + rustfmt
- **C/C++** - clangd + clang-format  
- **TypeScript/JavaScript** - tsserver + eslint + prettier
- **Python** - pyright + black + isort
- **HTML/CSS** - html + cssls + prettier
- **Tailwind CSS** - tailwindcss
- **C#** - omnisharp + csharpier
- **JSON/YAML** - jsonls + yamlls + prettier
- **Lua** - lua_ls + stylua
- **Bash** - bashls + shfmt
- **Docker** - dockerls
- **Markdown** - marksman + prettier
- **TOML** - taplo
- **CMake** - cmake + cmake-format

#### Additional Features
- **Git integration** - LazyGit
- **File explorer** - nvim-tree
- **Fuzzy finder** - Telescope with file browser
- **Debugging** - nvim-dap + dapui
- **Autocompletion** - nvim-cmp with LSP sources
- **Snippets** - LuaSnip with friendly-snippets
- **Session persistence** - persistence.nvim
- **Theme** - Dracula

#### C# Setup (OmniSharp)
**Prerequisites:**
- Install .NET SDK 6.0+ (tested with .NET 9)
```bash
# macOS (via Homebrew)
brew install dotnet

# Ubuntu/Debian
wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
sudo apt-get update
sudo apt-get install -y dotnet-sdk-8.0

# For other Ubuntu versions, replace "22.04" with your version (20.04, 24.04, etc.)
# Alternative Ubuntu installation via Snap:
# sudo snap install dotnet-sdk --classic

# Verify installation
dotnet --version
```

**Installation:**
1. Install via Mason (automatic when opening a .cs file)
2. The configuration automatically:
   - Sets DOTNET_ROOT environment variable
   - Configures OmniSharp with proper executable path
   - Enables Roslyn analyzers and import completion
   - Sets up EditorConfig support

**Known Issues:**
- Semantic tokens may show errors in logs (doesn't affect functionality)
- IntelliSense, go-to-definition, and autocomplete work correctly

**Optional Formatter:**
```bash
dotnet tool install -g csharpier
```

#### Notes
- All languages have full LSP support with formatting, linting, and IntelliSense
- C# support has been restored with OmniSharp-Roslyn
