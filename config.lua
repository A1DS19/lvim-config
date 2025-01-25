-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.colorscheme = "jellybeans"
lvim.transparent_window = false
lvim.builtin["terminal"].active = false

lvim.plugins = {
  { "lunarvim/colorschemes" },
  {
    "stevearc/dressing.nvim",
    config = function()
      require("dressing").setup({
        input = { enabled = false },
      })
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
    priority = 1001, -- optional but ensures it loads early
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
    "tamago324/lir.nvim",
    lazy = false,
    priority = 1000,
    -- Optional config if you have special lir settings:
    -- config = function()
    --   require("lir").setup({})
    -- end,
  },

  {
    "L3MON4D3/LuaSnip",
    lazy = false,
    priority = 1000,
    -- config = function()
    --   require("luasnip").setup({})
    -- end,
  },

  {
    "mfussenegger/nvim-dap",
    lazy = false,
    priority = 1000,
    -- config = function()
    --   -- Your DAP configuration here
    -- end,
  },

  {
    "rcarriga/nvim-dap-ui",
    lazy = false,
    priority = 1000,
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dapui").setup()
      -- If you want DAP UI to auto-open/close with DAP:
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
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({})
    end,
  },

  {
    "nvim-telescope/telescope-fzf-native.nvim",
    lazy = false,
    priority = 1000,
    build = "make", -- important if you need to compile the C code
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- Load on the BufReadPre event
    config = function()
      require("persistence").setup({
        -- Options here, or leave empty to use defaults
        dir = vim.fn.stdpath("data") .. "/sessions/", -- directory where session files are saved
        options = { "buffers", "curdir", "tabpages", "winsize" }, -- session options
        require("persistence").setup({
          require("persistence").setup({
  dir = vim.fn.stdpath("data") .. "/sessions/",
  options = { "buffers", "curdir", "tabpages", "winsize" },
  -- Enable autosave and autoload
  autoload = true, -- automatically load the session for the cwd
  autosave = {
    enabled = true,
    events = { "BufLeave", "VimLeavePre" }, -- autosave on these events
    last_session = true, -- always autosave the last session
  },
  telescope = {
    enabled = true,
    open_cmd = "Telescope",
  },
})

})

      })
    end,
    dependencies = { "nvim-lua/plenary.nvim" }, -- plenar.nvim is required
  },
}

lvim.keys.normal_mode["<leader>ff"] = "<cmd>Telescope find_files<CR>"
lvim.keys.normal_mode["<leader>fg"] = "<cmd>Telescope live_grep<CR>"
lvim.keys.normal_mode["<leader>fb"] = "<cmd>Telescope buffers<CR>"
lvim.keys.normal_mode["<leader>fh"] = "<cmd>Telescope help_tags<CR>"

lvim.keys.normal_mode["<leader>e"] = ":edit .<CR>"

-- Session Management Keybindings
-- Using the <leader> s prefix for session commands
-- Save the current session
lvim.keys.normal_mode["<leader>ss"] = "<cmd>lua require('persistence').save()<CR>"
-- Restore the last session
lvim.keys.normal_mode["<leader>sr"] = "<cmd>lua require('persistence').load()<CR>"
-- Stop persistence (do not auto-restore)
lvim.keys.normal_mode["<leader>sn"] = "<cmd>lua require('persistence').stop()<CR>"
-- List and switch between sessions using Telescope
lvim.keys.normal_mode["<leader>sl"] = "<cmd>lua require('persistence').load({ last = true })<CR>"
-- Save session with prompt for a name
lvim.keys.normal_mode["<leader>sa"] = "<cmd>lua require('persistence').save()<CR>"

