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
		opts = {
			highlight = { "MaterialYellow", "MaterialPurple", "MaterialBlue" },
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
				highlight = { "MaterialYellow", "MaterialPurple", "MaterialBlue" },
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
			require("material").setup(opts)
			vim.g.material_style = "palenight"
			vim.cmd.colorscheme("material")

			local colors = require("material.colors")
			-- colors for brackets
			vim.api.nvim_set_hl(0, "MaterialYellow", { fg = colors.main.yellow })
			vim.api.nvim_set_hl(0, "MaterialPurple", { fg = colors.main.purple })
			vim.api.nvim_set_hl(0, "MaterialBlue", { fg = colors.main.blue })

			-- color overrides for LSP
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)

					if client.name == "clangd" then
						vim.api.nvim_set_hl(0, "@lsp.type.class.c", { fg = colors.main.yellow })
						vim.api.nvim_set_hl(0, "@lsp.type.macro.c", { fg = colors.main.blue })
					elseif client.name == "pyright" then
						vim.api.nvim_set_hl(0, "@type.python", { fg = colors.main.yellow })
					elseif client.name == "tsserver" then
						local links = {
							[colors.main.yellow] = {
								-- BRUHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
								-- I pray for someone builds a material colorscheme
								-- that is more 1:1 with vscode or I'm gonna waste
								-- my entire life building one
								"@lsp.typemod.enumMember.readonly.typescriptreact",
								"@lsp.typemod.type.defaultLibrary.typescriptreact",
								"@lsp.typemod.class.defaultLibrary.typescriptreact",
								"@lsp.typemod.interface.defaultLibrary.typescriptreact",
								"@lsp.typemod.interface.declaration.typescriptreact",
								"@lsp.typemod.type.declaration.typescriptreact",
								"@lsp.type.type.typescriptreact",
								"@lsp.type.interface.typescriptreact",

								"@lsp.typemod.enumMember.readonly.typescript",
								"@lsp.typemod.interface.declaration.typescript",
								"@lsp.typemod.type.declaration.typescript",
								"@lsp.type.type.typescript",
								"@lsp.type.interface.typescript",

								"@constructor.tsx",
								"@type.typescript",
								"@type.tsx",
							},
							[colors.editor.fg] = "@constant",
						}

						for color, hl in pairs(links) do
							if type(hl) == "table" then
								for _, h in ipairs(hl) do
									vim.api.nvim_set_hl(0, h, { fg = color })
								end
							else
								vim.api.nvim_set_hl(0, hl, { fg = color })
							end
						end
					end
				end,
			})
		end,
	},
}
