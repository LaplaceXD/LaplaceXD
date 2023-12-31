return {
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
		local ok, loaders = pcall(require, "luasnip.loaders.from_vscode")

		if ok then
			loaders.lazy_load()
		end

		local cmp = require("cmp")
		local luasnip = require("luasnip")
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
					luasnip.lsp_expand(args.body)
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
	end,
}
