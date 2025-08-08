-- Load settings
require("settings")

-- Load plugins
require("plugins")

-- Load key mappings
require("keymaps")

-- GLSL file type detection
vim.filetype.add({
  extension = {
    vert = "glsl",
    frag = "glsl",
  },
})
