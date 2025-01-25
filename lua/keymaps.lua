-- General Key Mappings
lvim.keys.normal_mode["<leader>ff"] = "<cmd>Telescope find_files<CR>"
lvim.keys.normal_mode["<leader>fg"] = "<cmd>Telescope live_grep<CR>"
lvim.keys.normal_mode["<leader>fb"] = "<cmd>Telescope buffers<CR>"
lvim.keys.normal_mode["<leader>fh"] = "<cmd>Telescope help_tags<CR>"

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
