return {
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
					["@type.tsx"] = { fg = colors.main.darkgray },
					["@tag.builtin.tsx"] = { fg = colors.main.red },
					["@tag.tsx"] = { fg = colors.main.yellow },
					["@markup.heading"] = { fg = colors.main.darkgray },

					["@lsp.typemod.enumMember.readonly.typescript"] = { fg = colors.main.yellow },
					["@lsp.typemod.interface.declaration.typescript"] = { fg = colors.main.yellow },
					["@lsp.typemod.type.declaration.typescript"] = { fg = colors.main.yellow },
					["@lsp.type.type.typescript"] = { fg = colors.main.yellow },
					["@lsp.type.interface.typescript"] = { fg = colors.main.yellow },
					["@type.typescript"] = { fg = colors.main.darkgray },
					["@constant"] = { fg = colors.main.white },

					["@lsp.type.class.svelte"] = { fg = colors.main.yellow },
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
						local palette = require("github-theme.palette").load(vim.g.colors_name)
						vim.api.nvim_set_hl(0, "PrimaryBracketHighlight", { fg = palette.blue.bright })
						vim.api.nvim_set_hl(0, "SecondaryBracketHighlight", { fg = palette.green.bright })
						vim.api.nvim_set_hl(0, "TertiaryBracketHighlight", { fg = palette.yellow.bright })
					end
				end,
			})
		end,
	},
}
