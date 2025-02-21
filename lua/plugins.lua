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
							mirror = false, -- Mirror layout for two vertical columns
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
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- for file icons
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({
				default_component_configs = {
					icon = {
						folder_closed = "", -- Icon for closed folders
						folder_open = "", -- Icon for open folders
						folder_empty = "", -- Icon for empty folders
						default = "", -- Default icon for files
					},
				},
				window = {
					position = "left", -- Position the file explorer on the left side
					width = 33, -- Set the width of the file explorer
					mappings = {
						["<CR>"] = "open", -- Open files/folders with Enter
						["a"] = "add", -- Create a new file/folder
						["d"] = "delete", -- Delete a file/folder
						["r"] = "rename", -- Rename a file/folder
						["c"] = "copy_to_clipboard", -- Copy a file/folder
						["x"] = "cut_to_clipboard", -- Cut a file/folder
						["p"] = "paste_from_clipboard", -- Paste a file/folder
						["q"] = "close_window", -- Close the file explorer
						["v"] = "open_vsplit", -- Split vertical
					},
				},
				filesystem = {
					filtered_items = {
						visible = true, -- Show hidden files by default
						hide_dotfiles = false, -- Do not hide dotfiles
						hide_gitignored = false, -- Do not hide gitignored files
					},
				},
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
					"rust_analyzer", -- Rust
					"clangd", -- C/C++
					"csharp_ls", -- C#
					"tsserver", -- TypeScript/JavaScript
					"pyright", -- Python
					"eslint", -- ESLint for React/JS/TS
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
					-- Formatters
					null_ls.builtins.formatting.prettier.with({
						filetypes = {
							"javascript",
							"javascriptreact",
							"typescript",
							"typescriptreact",
							"json",
							"html",
							"css",
							"scss",
							"markdown",
						},
					}),
					null_ls.builtins.formatting.black.with({ -- Python
						extra_args = { "--fast" },
					}),
					null_ls.builtins.formatting.clang_format.with({ -- C/C++
						extra_args = { "--style=Google" },
					}),
					null_ls.builtins.formatting.rustfmt.with({ -- Rust
						extra_args = { "--edition=2021" },
					}),
					null_ls.builtins.formatting.csharpier, -- C#
					null_ls.builtins.formatting.stylua, -- Lua (optional)

					-- Linters
					null_ls.builtins.diagnostics.eslint.with({ -- ESLint for React/JS/TS
						condition = function(utils)
							return utils.root_has_file({ ".eslintrc.js", ".eslintrc.json", ".eslintrc.cjs" })
						end,
					}),
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Configure language servers
			lspconfig.rust_analyzer.setup({ capabilities = capabilities })
			lspconfig.clangd.setup({ capabilities = capabilities })
			lspconfig.csharp_ls.setup({ capabilities = capabilities })
			lspconfig.tsserver.setup({ capabilities = capabilities })
			lspconfig.pyright.setup({ capabilities = capabilities })
			lspconfig.eslint.setup({ capabilities = capabilities })
		end,
	},
}
