return {
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	{
		"windwp/windline.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("wlsample.evil_line")
		end,
	},

	{
		"HiPhish/rainbow-delimiters.nvim",
		event = "VeryLazy",
		config = function()
			vim.g.rainbow_delimiters = { highlight = { "Yellow", "Purple", "Blue" } }
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VeryLazy",
		main = "ibl",
		opts = {
			indent = {
				char = "▏",
				tab_char = "▏",
			},
			scope = {
				enabled = true,
				highlight = { "Yellow", "Purple", "Blue" },
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
		},
		config = function(_, opts)
			require("ibl").setup(opts)

			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
		end,
	},

	{
		"marko-cerovac/material.nvim",
		lazy = false,
		priority = 1000,
		name = "material",
		opts = {
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
		},
		config = function(_, opts)
			require("material").setup(opts)
			vim.g.material_style = "palenight"
			vim.cmd([[colorscheme material]])
		end,
	},
}
