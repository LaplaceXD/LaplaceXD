local web_format = function()
	local is_deno = vim.fs.root(0, { "deno.json", "deno.jsonc" })
	local lsp_fallback = "fallback"

	if is_deno then
		lsp_fallback = "prefer"
	end

	return { "prettierd", "prettier", stop_after_first = true, lsp_fallback }
end

return {
	"stevearc/conform.nvim",
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
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
			python = { "black", "autopep8", stop_after_first = true },
			javascript = web_format,
			javascriptreact = web_format,
			typescript = web_format,
			typescriptreact = web_format,
			svelte = web_format,
			vue = web_format,
			css = web_format,
			scss = web_format,
			less = web_format,
			html = web_format,
			json = web_format,
			jsonc = web_format,
			yaml = web_format,
			markdown = web_format,
			["markdown.mdx"] = web_format,
			graphql = web_format,
			handlebars = web_format,
			typst = { "typstfmt" },
		},
	},
	config = function(_, opts)
		local conform = require("conform")
		conform.setup(opts)

		vim.keymap.set("n", "<leader>f", function()
			conform.format({ async = true, lsp_fallback = true })
		end)
	end,
}
