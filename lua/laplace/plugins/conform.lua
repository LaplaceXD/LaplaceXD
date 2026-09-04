local js_format = function(bufnr)
	local is_ox = vim.fs.root(bufnr, { ".oxfmtrc.json", ".oxfmtrc.jsonc", "oxfmt.config.ts", "oxfmt.config.mts" })

	if is_ox then
		return { "oxfmt" }
	end

	local is_prettier = vim.fs.root(bufnr, {
		".prettierrc",
		".prettierrc.json",
		".prettierrc.yml",
		".prettierrc.yaml",
		".prettierrc.json5",
		".prettierrc.js",
		".prettierrc.cjs",
		".prettierrc.mjs",
		".prettierrc.ts",
		".prettierrc.cts",
		".prettierrc.mts",
		".prettierrc.toml",
		"prettier.config.js",
		"prettier.config.cjs",
		"prettier.config.mjs",
		"prettier.config.ts",
		"prettier.config.cts",
		"prettier.config.mts",
	})

	if is_prettier then
		return { "prettierd", "prettier", stop_after_first = true }
	end

	local is_deno = vim.fs.root(bufnr, { "deno.json", "deno.jsonc" })

	if is_deno then
		return { "deno_fmt" }
	end

	return { "oxfmt", "prettierd", "prettier", stop_after_first = true }
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
			javascript = js_format,
			javascriptreact = js_format,
			typescript = js_format,
			typescriptreact = js_format,
			svelte = js_format,
			vue = js_format,
			css = js_format,
			scss = js_format,
			less = js_format,
			html = js_format,
			json = js_format,
			jsonc = js_format,
			yaml = js_format,
			markdown = js_format,
			["markdown.mdx"] = js_format,
			graphql = js_format,
			handlebars = js_format,
			typst = { "typstfmt" },
			rust = { "rustfmt" },
		},
	},
	config = function(_, opts)
		local conform = require("conform")
		conform.setup(opts)

		vim.keymap.set("n", "<leader>f", function()
			conform.format({ async = true, lsp_format = "fallback" })
		end)
	end,
}
