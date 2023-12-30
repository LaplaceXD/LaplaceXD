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
	config = function(_, opts)
		local conform = require("conform")
		conform.setup(opts)

		vim.keymap.set("n", "<leader>f", function()
			conform.format({ async = true, lsp_fallback = true })
		end)
	end,
}
