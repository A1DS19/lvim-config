lvim.plugins = {
  { "lunarvim/colorschemes" },
  {
    "stevearc/dressing.nvim",
    config = function()
      require("dressing").setup({ input = { enabled = false } })
    end,
  },
  {
    "nvim-neorg/neorg",
    ft = "norg",
    config = true,
  },
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("dracula").setup({
        transparent_bg = false,      -- Enable/disable transparent background
        italic_comments = true,      -- Enable italic comments
      })
      vim.cmd("colorscheme dracula") -- Set the colorscheme to Dracula
    end,
  },
  {
    "rafamadriz/friendly-snippets",
    lazy = false,
    priority = 1001,
  },
  {
    "windwp/nvim-autopairs",
    lazy = false,
    priority = 1000,
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    lazy = false,
    priority = 1000,
  },
  {
    "mfussenegger/nvim-dap",
    lazy = false,
    priority = 1000,
  },
  {
    "rcarriga/nvim-dap-ui",
    lazy = false,
    priority = 1000,
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dapui").setup()
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
  {
    "nvim-lua/plenary.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "b0o/schemastore.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    priority = 1000,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function()
      local actions = require("telescope.actions")
      local fb_actions = require("telescope").extensions.file_browser.actions
      require("telescope").setup({
        defaults = {
          mappings = {
            n = {
              ["s"] = actions.select_horizontal,
              ["v"] = actions.select_vertical,
            },
            i = {
              ["<C-s>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
            },
          },
        },
        extensions = {
          file_browser = {
            theme = "dropdown",
            hijack_netrw = false,
            layout_strategy = "horizontal",
            layout_config = {
              width = 0.8,
              height = 0.9,
              prompt_position = "bottom",
              mirror = false,
            },
            mappings = {
              ["n"] = {
                ["<A-c>"] = fb_actions.create,
                ["<S-CR>"] = fb_actions.create_from_prompt,
                ["<A-r>"] = fb_actions.rename,
                ["<A-m>"] = fb_actions.move,
                ["<A-y>"] = fb_actions.copy,
                ["<A-d>"] = fb_actions.remove,
                ["<C-o>"] = fb_actions.open,
                ["<C-g>"] = fb_actions.goto_parent_dir,
                ["<C-e>"] = fb_actions.goto_home_dir,
                ["<C-w>"] = fb_actions.goto_cwd,
                ["<C-t>"] = fb_actions.change_cwd,
                ["<C-f>"] = fb_actions.toggle_browser,
                ["<C-h>"] = fb_actions.toggle_hidden,
                ["<C-s>"] = fb_actions.toggle_all,
                ["<BS>"] = fb_actions.backspace,
              },
            },
          },
        },
      })
      -- Load the file_browser extension
      pcall(require("telescope").load_extension, "file_browser")
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    lazy = true,
    priority = 1000,
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    lazy = false,
    priority = 1000,
    build = "make",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = function()
      require("persistence").setup({
        dir = vim.fn.stdpath("data") .. "/sessions/",
        options = { "buffers", "curdir", "tabpages", "winsize" },
        autoload = true,
        autosave = {
          enabled = true,
          events = { "BufLeave", "VimLeavePre" },
          last_session = true,
        },
        telescope = { enabled = true, open_cmd = "Telescope" },
      })
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        disable_netrw = true,
        hijack_netrw = true,
        update_cwd = false,
        update_focused_file = {
          enable = false,
          update_cwd = false,
        },
        view = {
          width = 35,
          side = "left",
          number = false,
          relativenumber = false,
        },
        filters = {
          dotfiles = false,
          git_clean = false,
          git_ignored = false,
          custom = {},
        },
        git = {
          ignore = false,
        },
        actions = {
          open_file = {
            quit_on_open = false,
          },
        },
        on_attach = function(bufnr)
          local api = require("nvim-tree.api")
          api.config.mappings.default_on_attach(bufnr)
          vim.keymap.set("n", "v", api.node.open.vertical, {
            desc = "nvim-tree: Open in vertical split",
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true,
          })
        end,
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "rust_analyzer",
          "clangd",
          "omnisharp",
          "tsserver",
          "pyright",
          "eslint",
          "html",
          "cssls",
          "tailwindcss",
          "jsonls",
          "yamlls",
          "lua_ls",
          "bashls",
          "dockerls",
          "marksman",
          "taplo",
          "cmake",
        },
      })
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettier.with({
            filetypes = {
              "javascript",
              "typescript",
              "javascriptreact",
              "typescriptreact",
              "json",
              "html",
              "css",
              "scss",
              "markdown",
              "yaml",
            },
          }),
          null_ls.builtins.formatting.eslint_d.with({
            condition = function(utils)
              return utils.root_has_file({
                ".eslintrc.js",
                ".eslintrc.cjs",
                ".eslintrc.json",
                "package.json",
              })
            end,
          }),
          null_ls.builtins.code_actions.eslint_d,
          null_ls.builtins.formatting.csharpier,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,
          null_ls.builtins.formatting.rustfmt,
          null_ls.builtins.formatting.clang_format,
          null_ls.builtins.formatting.shfmt,
          null_ls.builtins.formatting.yamlfmt,
          null_ls.builtins.formatting.cmake_format,
          null_ls.builtins.diagnostics.eslint.with({
            condition = function(utils)
              return utils.root_has_file({ ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json" })
            end,
          }),
          null_ls.builtins.diagnostics.yamllint,
          null_ls.builtins.diagnostics.cmake_lint,
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local util = require("lspconfig.util")

      lspconfig.rust_analyzer.setup({ capabilities = capabilities })
      lspconfig.clangd.setup({ capabilities = capabilities })

      lspconfig.omnisharp.setup({
        capabilities = capabilities,
        cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
        enable_editorconfig_support = true,
        enable_ms_build_load_projects_on_demand = false,
        enable_roslyn_analyzers = false,
        organize_imports_on_format = false,
        enable_import_completion = false,
        sdk_include_prereleases = true,
        analyze_open_documents_only = false,
      })

      lspconfig.tsserver.setup({ capabilities = capabilities })
      lspconfig.pyright.setup({ capabilities = capabilities })
      lspconfig.eslint.setup({ capabilities = capabilities })

      lspconfig.html.setup({
        capabilities = capabilities,
        filetypes = { "html", "htmldjango" },
      })
      lspconfig.cssls.setup({
        capabilities = capabilities,
        filetypes = { "css", "scss", "less" },
      })
      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
        filetypes = {
          "html",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "css",
          "scss",
          "svelte",
        },
        root_dir = util.root_pattern(
          "tailwind.config.js",
          "tailwind.config.cjs",
          "postcss.config.js",
          "package.json"
        ),
        init_options = {
          userLanguages = {
            html = "html",
            typescript = "typescript",
            javascript = "javascript",
          },
        },
      })

      lspconfig.jsonls.setup({
        capabilities = capabilities,
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      })

      lspconfig.yamlls.setup({
        capabilities = capabilities,
        settings = {
          yaml = {
            schemaStore = {
              enable = false,
              url = "",
            },
            schemas = require("schemastore").yaml.schemas(),
          },
        },
      })

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            telemetry = { enable = false },
          },
        },
      })

      lspconfig.bashls.setup({ capabilities = capabilities })
      lspconfig.dockerls.setup({ capabilities = capabilities })
      lspconfig.marksman.setup({ capabilities = capabilities })
      lspconfig.taplo.setup({ capabilities = capabilities })

      lspconfig.cmake.setup({
        capabilities = capabilities,
        filetypes = { "cmake" },
        init_options = {
          buildDirectory = "build",
        },
      })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "html",
          "css",
          "javascript",
          "typescript",
          "tsx",
          "json",
          "yaml",
          "toml",
          "c_sharp",
          "c",
          "cpp",
          "rust",
          "python",
          "lua",
          "bash",
          "markdown",
          "markdown_inline",
          "dockerfile",
          "cmake",
          "make",
          "vim",
          "vimdoc",
          "sql",
          "regex",
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
      })
    end,
  },
  {
    "Civitasv/cmake-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("cmake-tools").setup({
        cmake_command = "cmake",
        cmake_build_directory = "build",
        cmake_build_directory_prefix = "",
        cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
        cmake_build_options = {},
        cmake_console_position = "belowright",
        cmake_console_size = 10,
        cmake_show_console = "always",
        cmake_dap_configuration = {
          name = "cpp",
          type = "codelldb",
          request = "launch",
        },
      })
    end,
  },
  {
    "LhKipp/nvim-nu",
    ft = "nu",
    config = function()
      require("nu").setup()
    end,
  },
}
