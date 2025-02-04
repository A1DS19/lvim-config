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
    "nanotech/jellybeans.vim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme jellybeans")
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
          hijack_netrw = true,
          layout_strategy = "horizontal", -- Use vertical layout
          layout_config = {
            width = 0.8,
            height = 0.9,
            prompt_position = "bottom",
            mirror = false,  -- Mirror layout for two vertical columns
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
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
  },
}
