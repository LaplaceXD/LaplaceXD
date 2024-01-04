return {
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	-- {
	-- "Bekaboo/dropbar.nvim",
	-- event = "VeryLazy",
	-- dependencies = {
	-- "nvim-telescope/telescope-fzf-native.nvim",
	-- },
	-- },

	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {
			input = { relative = "editor" },
		},
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
		"HiPhish/rainbow-delimiters.nvim",
		event = "VeryLazy",
		opts = {
			highlight = { "PrimaryBracketHighlight", "SecondaryBracketHighlight", "TertiaryBracketHighlight" },
			query = { tsx = "rainbow-parens", html = "rainbow-parens" },
		},
		config = function(_, opts)
			require("rainbow-delimiters.setup").setup(opts)
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
				highlight = { "PrimaryBracketHighlight", "SecondaryBracketHighlight", "TertiaryBracketHighlight" },
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
}
