-- Basic Settings
lvim.colorscheme = "jellybeans"
lvim.transparent_window = false
lvim.builtin["terminal"].active = false

-- Plugins
lvim.plugins = {
  { "lunarvim/colorschemes" },
  -- Uncomment if you want to use nvim-web-devicons independently
  -- {
  --   "kyazdani42/nvim-web-devicons",
  --   lazy = true,
  -- },
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
    priority = 1001, -- Optional but ensures it loads early
  },
  {
    "windwp/nvim-autopairs",
    lazy = false,
    priority = 1000,
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },
  -- Removed lir.nvim
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
      require("telescope").setup({
        extensions = {
          file_browser = {
            theme = "dropdown",
            hijack_netrw = true,
            layout_config = {
              width = 0.9,
              height = 0.8,
            },
            mappings = {
              ["n"] = {
                ["<A-c>"] = require("telescope").extensions.file_browser.actions.create,
                ["<S-CR>"] = require("telescope").extensions.file_browser.actions.create_from_prompt,
                ["<A-r>"] = require("telescope").extensions.file_browser.actions.rename,
                ["<A-m>"] = require("telescope").extensions.file_browser.actions.move,
                ["<A-y>"] = require("telescope").extensions.file_browser.actions.copy,
                ["<A-d>"] = require("telescope").extensions.file_browser.actions.remove,
                ["<C-o>"] = require("telescope").extensions.file_browser.actions.open,
                ["<C-g>"] = require("telescope").extensions.file_browser.actions.goto_parent_dir,
                ["<C-e>"] = require("telescope").extensions.file_browser.actions.goto_home_dir,
                ["<C-w>"] = require("telescope").extensions.file_browser.actions.goto_cwd,
                ["<C-t>"] = require("telescope").extensions.file_browser.actions.change_cwd,
                ["<C-f>"] = require("telescope").extensions.file_browser.actions.toggle_browser,
                ["<C-h>"] = require("telescope").extensions.file_browser.actions.toggle_hidden,
                ["<C-s>"] = require("telescope").extensions.file_browser.actions.toggle_all,
                -- Removed invalid mappings
                -- ["<Tab>"] = require("telescope").extensions.file_browser.actions.toggle_selection_next,
                -- ["<S-Tab>"] = require("telescope").extensions.file_browser.actions.toggle_selection_prev,
                ["<BS>"] = require("telescope").extensions.file_browser.actions.backspace,
              },
              ["i"] = {
                ["<A-c>"] = require("telescope").extensions.file_browser.actions.create,
                ["<S-CR>"] = require("telescope").extensions.file_browser.actions.create_from_prompt,
                ["<A-r>"] = require("telescope").extensions.file_browser.actions.rename,
                ["<A-m>"] = require("telescope").extensions.file_browser.actions.move,
                ["<A-y>"] = require("telescope").extensions.file_browser.actions.copy,
                ["<A-d>"] = require("telescope").extensions.file_browser.actions.remove,
                ["<C-o>"] = require("telescope").extensions.file_browser.actions.open,
                ["<C-g>"] = require("telescope").extensions.file_browser.actions.goto_parent_dir,
                ["<C-e>"] = require("telescope").extensions.file_browser.actions.goto_home_dir,
                ["<C-w>"] = require("telescope").extensions.file_browser.actions.goto_cwd,
                ["<C-t>"] = require("telescope").extensions.file_browser.actions.change_cwd,
                ["<C-f>"] = require("telescope").extensions.file_browser.actions.toggle_browser,
                ["<C-h>"] = require("telescope").extensions.file_browser.actions.toggle_hidden,
                ["<C-s>"] = require("telescope").extensions.file_browser.actions.toggle_all,
                -- Removed invalid mappings
                -- ["<Tab>"] = require("telescope").extensions.file_browser.actions.toggle_selection_next,
                -- ["<S-Tab>"] = require("telescope").extensions.file_browser.actions.toggle_selection_prev,
                ["<BS>"] = require("telescope").extensions.file_browser.actions.backspace,
              },
            },
          },
        },
      })
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    lazy = false,
    priority = 1000,
    build = "make", -- Important if you need to compile the C code
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").load_extension("file_browser")
    end,
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- Load on the BufReadPre event
    config = function()
      require("persistence").setup({
        dir = vim.fn.stdpath("data") .. "/sessions/", -- Directory where session files are saved
        options = { "buffers", "curdir", "tabpages", "winsize" }, -- Session options
        autoload = true, -- Automatically load the session for the current working directory
        autosave = {
          enabled = true,
          events = { "BufLeave", "VimLeavePre" }, -- Autosave on these events
          last_session = true, -- Always autosave the last session
        },
        telescope = {
          enabled = true,
          open_cmd = "Telescope", -- Telescope command prefix
        },
      })
    end,
    dependencies = { "nvim-lua/plenary.nvim" }, -- plenary.nvim is required
  },
}

-- Key Mappings
lvim.keys.normal_mode["<leader>ff"] = "<cmd>Telescope find_files<CR>"
lvim.keys.normal_mode["<leader>fg"] = "<cmd>Telescope live_grep<CR>"
lvim.keys.normal_mode["<leader>fb"] = "<cmd>Telescope buffers<CR>"
lvim.keys.normal_mode["<leader>fh"] = "<cmd>Telescope help_tags<CR>"

-- Set <leader>e to Telescope File Browser
lvim.keys.normal_mode["<leader>e"] = "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>"

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
lvim.keys.normal_mode["<leader>sa"] = "<cmd>lua save_session_with_name()<CR>"

-- Custom function to prompt for a session name
function save_session_with_name()
  local session_name = vim.fn.input("Session Name: ")
  if session_name ~= "" then
    require("persistence").save(session_name)
  else
    print("Session name cannot be empty!")
  end
end

-- Enhanced Key Mappings with which-key
lvim.builtin.which_key.mappings["f"] = {
  name = "Find",
  f = { "<cmd>Telescope find_files<CR>", "Find Files" },
  g = { "<cmd>Telescope live_grep<CR>", "Live Grep" },
  b = { "<cmd>Telescope buffers<CR>", "Buffers" },
  h = { "<cmd>Telescope help_tags<CR>", "Help Tags" },
}

lvim.builtin.which_key.mappings["e"] = { "<cmd>Telescope file_browser<CR>", "File Browser" }

lvim.builtin.which_key.mappings["s"] = {
  name = "Session",
  s = { "<cmd>lua require('persistence').save()<CR>", "Save Session" },
  r = { "<cmd>lua require('persistence').load()<CR>", "Restore Session" },
  n = { "<cmd>lua require('persistence').stop()<CR>", "Stop Persistence" },
  l = { "<cmd>lua require('persistence').load({ last = true })<CR>", "Restore Last Session" },
  a = { "<cmd>lua save_session_with_name()<CR>", "Save Session with Name" }, -- Custom function
}

