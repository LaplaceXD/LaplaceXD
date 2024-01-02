return {
	{ "nvim-tree/nvim-web-devicons", lazy = true },

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
			query = { tsx = "rainbow-parens" },
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
			local colors = require("material.colors")

			-- LSP color overrides, since this theme lacks yellow
			require("material").setup(vim.tbl_deep_extend("force", opts, {
				custom_highlights = {
					["@lsp.type.class.c"] = { fg = colors.main.yellow },
					["@lsp.type.macro.c"] = { fg = colors.main.blue },

					["@type.python"] = { fg = colors.main.yellow },

					["@lsp.typemod.enumMember.readonly.typescriptreact"] = { fg = colors.main.yellow },
					["@lsp.typemod.type.defaultLibrary.typescriptreact"] = { fg = colors.main.yellow },
					["@lsp.typemod.class.defaultLibrary.typescriptreact"] = { fg = colors.main.yellow },
					["@lsp.typemod.interface.defaultLibrary.typescriptreact"] = { fg = colors.main.yellow },
					["@lsp.typemod.interface.declaration.typescriptreact"] = { fg = colors.main.yellow },
					["@lsp.typemod.type.declaration.typescriptreact"] = { fg = colors.main.yellow },
					["@lsp.type.type.typescriptreact"] = { fg = colors.main.yellow },
					["@lsp.type.interface.typescriptreact"] = { fg = colors.main.yellow },
					["@constructor.tsx"] = { fg = colors.main.yellow },
					["@type.tsx"] = { fg = colors.main.yellow },

					["@lsp.typemod.enumMember.readonly.typescript"] = { fg = colors.main.yellow },
					["@lsp.typemod.interface.declaration.typescript"] = { fg = colors.main.yellow },
					["@lsp.typemod.type.declaration.typescript"] = { fg = colors.main.yellow },
					["@lsp.type.type.typescript"] = { fg = colors.main.yellow },
					["@lsp.type.interface.typescript"] = { fg = colors.main.yellow },
					["@type.typescript"] = { fg = colors.main.yellow },
					["@constant"] = { fg = colors.main.white },
				},
			}))

			-- Bracket Colorizer overrides
			vim.api.nvim_create_autocmd("Colorscheme", {
				callback = function()
					local scheme_prefix = "material"
					local current_scheme_prefix = vim.g.colors_name and vim.g.colors_name:sub(1, #scheme_prefix) or ""

					if scheme_prefix == current_scheme_prefix then
						vim.api.nvim_set_hl(0, "PrimaryBracketHighlight", { fg = colors.main.yellow })
						vim.api.nvim_set_hl(0, "SecondaryBracketHighlight", { fg = colors.main.purple })
						vim.api.nvim_set_hl(0, "TertiaryBracketHighlight", { fg = colors.main.blue })
					end
				end,
			})

			vim.g.material_style = "palenight"
			vim.cmd.colorscheme("material")
		end,
	},

	{
		"projekt0n/github-nvim-theme",
		lazy = false,
		priority = 1000,
		opts = {
			options = {
				transparent = true,
			},
			palettes = {
				all = {
					black = { base = "", bright = "" },
				},
			},
			groups = {
				all = {
					NormalFloat = {},
					FloatBorder = { fg = "white" },
				},
			},
		},
		config = function(_, opts)
			require("github-theme").setup(opts)

			-- Bracket Colorizer overrides
			vim.api.nvim_create_autocmd("Colorscheme", {
				callback = function()
					local scheme_prefix = "github"
					local current_scheme_prefix = vim.g.colors_name and vim.g.colors_name:sub(1, #scheme_prefix) or ""

					if scheme_prefix == current_scheme_prefix then
						local palette = require("github-theme.palette").load("githu_dark_default")
						vim.api.nvim_set_hl(0, "PrimaryBracketHighlight", { fg = palette.blue.bright })
						vim.api.nvim_set_hl(0, "SecondaryBracketHighlight", { fg = palette.green.bright })
						vim.api.nvim_set_hl(0, "TertiaryBracketHighlight", { fg = palette.yellow.bright })
					end
				end,
			})
		end,
	},
}
