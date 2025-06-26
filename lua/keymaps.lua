-- General Key Mappings
lvim.keys.normal_mode["<leader>ff"] = "<cmd>Telescope find_files<CR>"
lvim.keys.normal_mode["<leader>fg"] = "<cmd>Telescope live_grep<CR>"
lvim.keys.normal_mode["<leader>fb"] = "<cmd>Telescope buffers<CR>"
lvim.keys.normal_mode["<leader>fh"] = "<cmd>Telescope help_tags<CR>"
lvim.keys.normal_mode["<leader>bd"] = "<cmd>bd<CR>"
lvim.keys.normal_mode["<leader>bn"] = "<cmd>bn<CR>"
lvim.keys.normal_mode["<leader>bp"] = "<cmd>bp<CR>"

-- File Browser
lvim.keys.normal_mode["<leader>e"] = "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>"

-- Session Management
lvim.keys.normal_mode["<leader>ss"] = "<cmd>lua require('persistence').save()<CR>"
lvim.keys.normal_mode["<leader>sr"] = "<cmd>lua require('persistence').load()<CR>"
lvim.keys.normal_mode["<leader>sn"] = "<cmd>lua require('persistence').stop()<CR>"
lvim.keys.normal_mode["<leader>sl"] = "<cmd>lua require('persistence').load({ last = true })<CR>"
lvim.keys.normal_mode["<leader>sa"] = "<cmd>lua save_session_with_name()<CR>"

-- Custom function to save session with a name
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

-- LazyGit
lvim.keys.normal_mode["<leader>lg"] = "<cmd>LazyGit<CR>"

-- Terminal
lvim.builtin.terminal.active = true
lvim.builtin.terminal.open_mapping = "<leader>tt"

-- Neotree mappings
lvim.keys.normal_mode["<C-t>"] = ":NvimTreeToggle<CR>"
-- vim.api.nvim_create_autocmd("BufEnter", {
--   callback = function()
--     -- Get the list of current windows.
--     if #vim.api.nvim_list_wins() == 1 then
--       -- Check if the current buffer's filetype is neo-tree.
--       if vim.bo.filetype == "neo-tree" then
--         vim.cmd("quit")
--       end
--     end
--   end,
-- })

-- Go to Definition and Go to Implementation
lvim.keys.normal_mode["gd"] = "<cmd>lua vim.lsp.buf.definition()<CR>"
lvim.keys.normal_mode["gI"] = "<cmd>lua vim.lsp.buf.implementation()<CR>"

-- format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.rs", "*.c", "*.cpp", "*.cs", "*.ts", "*.tsx", "*.js", "*.jsx", "*.py", "*.lua", "*.hpp", "*.h" },
  callback = function()
    vim.lsp.buf.format({ async = false })
    print("File formatted and saved!")
  end,
})
