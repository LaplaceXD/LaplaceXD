local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	{
		"andweeb/presence.nvim",
		event = "VeryLazy",
		opts = { main_image = "file" },
	},

	{
		"windwp/windline.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("wlsample.evil_line")
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VeryLazy",
		main = "ibl",
		dependencies = { "HiPhish/rainbow-delimiters.nvim" },
		config = function()
			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

			local highlight = { "Yellow", "Purple", "Blue" }
			vim.g.rainbow_delimiters = { highlight = highlight }
			require("ibl").setup({
				indent = {
					char = "▏",
					tab_char = "▏",
				},
				scope = {
					enabled = true,
					highlight = highlight,
					show_exact_scope = true,
					show_start = false,
					show_end = false,
				},
				exclude = {
					filetypes = {
						"help",
						"alpha",
						"dashboard",
						"neo-tree",
						"Trouble",
						"trouble",
						"lazy",
						"mason",
						"notify",
						"toggleterm",
						"lazyterm",
					},
				},
			})
		end,
	},

	{
		"marko-cerovac/material.nvim",
		lazy = false,
		priority = 1000,
		name = "material",
		config = function()
			require("material").setup({
				contrast = {
					terminal = true,
					sidebars = true,
					floating_windows = true,
					cursor_line = true,
					non_current_windows = true,
				},
				plugins = {
					"gitsigns",
					"harpoon",
					"lspsaga",
					"indent-blankline",
					"rainbow-delimiters",
					"mini",
					"nvim-cmp",
					"nvim-web-devicons",
					"telescope",
					"trouble",
				},
				custom_colors = function(colors)
					-- Bracket Colors
					vim.api.nvim_set_hl(0, "Yellow", { fg = colors.main.yellow })
					vim.api.nvim_set_hl(0, "Purple", { fg = colors.main.purple })
					vim.api.nvim_set_hl(0, "Blue", { fg = colors.main.blue })

					colors.main.black = "" -- make statusline background transparent
					colors.main.darkpurple = colors.main.paleblue -- darkpurple is too harsh for lsp autosuggestions
					colors.editor.accent = colors.main.darkpurple
				end,
				disable = {
					background = true,
					colored_cursor = true,
				},
			})
			vim.g.material_style = "palenight"
			vim.cmd([[colorscheme material]])
		end,
	},

	{
		"mbbill/undotree",
		keys = {
			{ "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree", mode = "n" },
		},
	},

	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Toggle Trouble", mode = "n" },
		},
	},

	{
		"tpope/vim-fugitive",
		cmd = { "Git" },
		keys = {
			{ "<leader>gs", "<cmd>Git<cr>", desc = "Toggle Git", mode = "n" },
		},
	},

	{
		"lewis6991/gitsigns.nvim",
		opts = { current_line_blame_opts = { delay = 250 } },
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{
				"<leader>gb",
				"<cmd>Gitsigns toggle_current_line_blame<cr>",
				desc = "Toggle Current Line Blame",
				mode = "n",
			},
		},
	},

	{
		"stevearc/conform.nvim",
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				mode = "n",
				desc = "Format buffer",
			},
		},
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					lua = { "stylua" },
					c = { "clang-format" },
					cpp = { "clang-format" },
					go = { "goimports", "gofmt" },
					python = { "autopep8" },
					javascript = { { "prettierd", "prettier" } },
					javascriptreact = { { "prettierd", "prettier" } },
					typescript = { { "prettierd", "prettier" } },
					typescriptreact = { { "prettierd", "prettier" } },
					vue = { { "prettierd", "prettier" } },
					css = { { "prettierd", "prettier" } },
					scss = { { "prettierd", "prettier" } },
					less = { { "prettierd", "prettier" } },
					html = { { "prettierd", "prettier" } },
					json = { { "prettierd", "prettier" } },
					jsonc = { { "prettierd", "prettier" } },
					yaml = { { "prettierd", "prettier" } },
					markdown = { { "prettierd", "prettier" } },
					["markdown.mdx"] = { { "prettierd", "prettier" } },
					graphql = { { "prettierd", "prettier" } },
					handlebars = { { "prettierd", "prettier" } },
				},
			})

			vim.keymap.set("n", "<leader>f", function()
				conform.format({ async = true, lsp_fallback = true })
			end)
		end,
	},

	{
		"Pocco81/auto-save.nvim",
		event = { "InsertLeave", "FocusLost", "VimLeavePre" },
		opts = { trigger_events = { "InsertLeave", "FocusLost", "VimLeavePre" } },
	},

	{
		"windwp/nvim-autopairs",
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
	},

	{
		"windwp/nvim-ts-autotag",
		ft = {
			"html",
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
			"svelte",
			"vue",
			"tsx",
			"jsx",
			"rescript",
			"xml",
			"php",
			"markdown",
			"astro",
			"glimmer",
			"handlebars",
			"hbs",
		},
		opts = {},
	},

	{
		"echasnovski/mini.files",
		keys = {
			{ "<leader>d", "<cmd>lua MiniFiles.open()<cr>", desc = "Open File Tree", mode = "n" },
		},
		opts = {
			options = {
				use_as_default_explorer = false,
				permanent_delete = false,
			},
			mappings = {
				go_in = "L",
				go_in_plus = "l",
				go_out = "H",
				go_out_plus = "h",
			},
			windows = {
				preview = true,
				max_number = 4,
				width_focus = 25,
				width_nofocus = 25,
				width_preview = 50,
			},
		},
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "nvim-treesitter/nvim-treesitter" },
		opts = {
			path_display = "smart",
		},
		keys = {
			{
				"<leader>pf",
				desc = "Find files within Project Directory",
				mode = "n",
			},
			{
				"<C-p>",
				desc = "Find Files within Git Directory",
				mode = "n",
			},
			{
				"<leader>ps",
				desc = "Find Files with a Search String in a Project Directory",
				mode = "n",
			},
		},
		config = function()
			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader>pf", builtin.find_files)
			vim.keymap.set("n", "<C-p>", function()
				builtin.git_files({ show_untracked = true })
			end)
			vim.keymap.set("n", "<leader>ps", function()
				builtin.grep_string({ search = vim.fn.input("Grep > ") })
			end)
		end,
	},

	{
		"theprimeagen/harpoon",
		keys = {
			{
				"<leader>a",
				desc = "Add a file to harpoon stash",
				mode = "n",
			},
			{
				"<C-e>",
				desc = "Open harpoon stash",
				mode = "n",
			},
			{
				"<C-h>",
				desc = "Goto harpooned file 1",
				mode = "n",
			},
			{
				"<C-t>",
				desc = "Goto harpooned file 2",
				mode = "n",
			},
			{
				"<C-n>",
				desc = "Goto harpooned file 3",
				mode = "n",
			},
			{
				"<C-s>",
				desc = "Goto harpooned file 4",
				mode = "n",
			},
		},
		config = function()
			local mark = require("harpoon.mark")
			local ui = require("harpoon.ui")

			vim.keymap.set("n", "<leader>a", mark.add_file)
			vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

			vim.keymap.set("n", "<C-h>", function()
				ui.nav_file(1)
			end)
			vim.keymap.set("n", "<C-t>", function()
				ui.nav_file(2)
			end)
			vim.keymap.set("n", "<C-n>", function()
				ui.nav_file(3)
			end)
			vim.keymap.set("n", "<C-s>", function()
				ui.nav_file(4)
			end)
		end,
	},

	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_combine_preview = 1
			vim.g.mkdp_auto_close = 0

			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},

	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"html",
					"css",
					"javascript",
					"typescript",
					"tsx",
					"go",
					"python",
					"c",
					"markdown",
					"markdown_inline",
					"json",
					"jsonc",
					"lua",
				},

				sync_install = false,
				auto_install = true,

				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
			})
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter" },
		keys = {
			{ ":", mode = "n" },
			{ "?", mode = "n" },
			{ "/", mode = "n" },
		},
		dependencies = {
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",

			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local ok, luasnip = pcall(require, "luasnip.loaders.from_vscode")

			if ok then
				luasnip.lazy_load()
			end

			local cmp = require("cmp")
			local cmp_select = { behavior = cmp.SelectBehavior.Select }

			local symbols = {
				Text = "",
				Method = "",
				Function = "",
				Constructor = "",
				Field = "",
				Variable = "",
				Class = "",
				Interface = "",
				Module = "",
				Property = "",
				Unit = "",
				Value = "",
				Enum = "",
				Keyword = "",
				Snippet = "",
				Color = "",
				File = "",
				Reference = "",
				Folder = "",
				EnumMember = "",
				Constant = "",
				Struct = "",
				Event = "",
				Operator = "",
				TypeParameter = "",
			}

			cmp.setup({
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
				}),
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(_, item)
						item.abbr = string.len(item.abbr) > 30 and vim.fn.strcharpart(item.abbr, 0, 27) .. "..."
							or item.abbr
						item.menu = item.kind or ""
						item.kind = symbols[item.kind] or ""

						return item
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
					["<Tab>"] = cmp.mapping.confirm({ select = true }),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete({
						reason = cmp.ContextReason.Auto,
					}),
				}),
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
			})

			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({ { name = "cmp_git" }, { name = "buffer" } }),
			})

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = { { name = "buffer" } },
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({ { name = "path" }, { name = "cmdline" } }),
			})

			-- transparent background for suggestion windows
			vim.cmd([[hi Pmenu guibg=none]])
		end,
	},

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		cmd = { "Mason" },
		build = ":MasonUpdate",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			require("mason").setup({ ui = { border = "rounded" } })

			local lsp = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			require("mason-lspconfig").setup({
				ensure_installed = {
					"clangd",
					"lua_ls",
					"gopls",
					"tsserver",
					"html",
					"cssls",
					"tailwindcss",
					"pyright",
				},
				handlers = {
					function(server)
						lsp[server].setup({ capabilities = capabilities })
					end,
					["lua_ls"] = function()
						lsp.lua_ls.setup({
							capabilities = capabilities,
							settings = {
								Lua = {
									runtime = { version = "LuaJIT" },
									diagnostics = { globals = { "vim" } },
									workspace = { library = { vim.env.VIMRUNTIME } },
								},
							},
						})
					end,
					["clangd"] = function()
						lsp.clangd.setup({
							-- Need to setup %UserProfile%/AppData/Local/clangd/config.yaml as well
							-- CompileFlags:
							--   Compiler: <same-as-query-driver>
							capabilities = capabilities,
							cmd = {
								"clangd",
								"--query-driver=C:\\dev\\msys64\\ucrt64\\bin\\gcc,C:\\dev\\msys64\\ucrt64\\bin\\g++",
							},
						})
					end,
				},
			})
		end,
	},
})
