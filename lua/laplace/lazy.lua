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
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = { theme = "material" },
	},

	{
		"marko-cerovac/material.nvim",
		lazy = false,
		priority = 1000,
		name = "material",
		config = function()
			require("material").setup({
				plugins = {
					"gitsigns",
					"harpoon",
					"lspsaga",
					"mini",
					"nvim-cmp",
					"nvim-web-devicons",
					"telescope",
					"trouble",
				},
				disable = {
					background = true,
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
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "n",
				desc = "Format buffer",
			},
		},
		opts = {
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
		},
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
			{ "<C-o>", "<cmd>lua MiniFiles.open()<cr>", desc = "Open File Tree", mode = "n" },
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
		lazy = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{
				"<leader>pf",
				"<cmd>Telescope find_files<cr>",
				desc = "Find files within Project Directory",
				mode = "n",
			},
			{
				"<C-p>",
				function()
					require("telescope.builtin").git_files({ show_untracked = true })
				end,
				desc = "Find Files within Git Directory",
				mode = "n",
			},
			{
				"<leader>ps",
				function()
					require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
				end,
				desc = "Find Files within Git Directory",
				mode = "n",
			},
		},
	},

	{
		"theprimeagen/harpoon",
		event = "BufEnter",
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
			vim.g.mkdp_auto_start = 1
			vim.g.mkdp_auto_close = 0

			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},

	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		lazy = false,
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
		"VonHeikemen/lsp-zero.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"neovim/nvim-lspconfig",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",

			"rafamadriz/friendly-snippets",
		},
		config = function()
			local lsp_zero = require("lsp-zero")

			lsp_zero.on_attach(function(_, bufnr)
				local opts = { buffer = bufnr, remap = false }

				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
				vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
				vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
				vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
				vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
			end)

			lsp_zero.set_sign_icons({
				error = "",
				warn = "",
				hint = "⚑",
				info = "»",
			})

			-- Configure LSPs
			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = {
					"clangd",
					"lua_ls",
					"gopls",
					"tsserver",
					"html",
					"cssls",
					"eslint",
					"tailwindcss",
					"pyright",
				},
				handlers = {
					lsp_zero.default_setup,
					["clangd"] = function()
						require("lspconfig").clangd.setup({
							-- Need to setup %UserProfile%/AppData/Local/clangd/config.yaml as well
							-- CompileFlags:
							--  Compiler: <same-as-query-driver>
							cmd = {
								"clangd",
								"--query-driver=C:\\dev\\msys64\\ucrt64\\bin\\gcc,C:\\dev\\msys64\\ucrt64\\bin\\g++",
							},
						})
					end,
				},
			})

			-- Configure Snippets
			require("luasnip/loaders/from_vscode").lazy_load()

			-- Configure Autocompletion Suggestions
			local cmp = require("cmp")
			local cmp_select = { behavior = cmp.SelectBehavior.Select }

			cmp.setup({
				sources = {
					{ name = "path" },
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
					{ name = "luasnip" },
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				formatting = lsp_zero.cmp_format(),
				mapping = cmp.mapping.preset.insert({
					["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
					["<Tab>"] = cmp.mapping.confirm({ select = true }),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-X>"] = cmp.mapping(
						cmp.mapping.complete({
							reason = cmp.ContextReason.Auto,
						}),
						{ "i", "c" }
					),
				}),
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
			})
		end,
	},
})