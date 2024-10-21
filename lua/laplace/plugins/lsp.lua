return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	cmd = { "Mason" },
	build = ":MasonUpdate",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		require("mason").setup({ ui = { border = "rounded" } })

		local lsp = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		require("mason-lspconfig").setup({
			ensure_installed = {
				"clangd",
				"cssls",
				"denols",
				"gopls",
				"html",
				"lua_ls",
				"tailwindcss",
				"ts_ls",
			},
			handlers = {
				function(server)
					lsp[server].setup({ capabilities = capabilities })
				end,
				["lua_ls"] = function()
					lsp.lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								runtime = { version = "LuaJIT" },
								diagnostics = { globals = { "vim" } },
								workspace = { library = { vim.env.VIMRUNTIME } },
							},
						},
					})
				end,
				["denols"] = function()
					lsp.denols.setup({
						capabilities = capabilities,
						root_dir = lsp.util.root_pattern("deno.jsonc", "deno.json"),
					})
				end,
				["ts_ls"] = function()
					lsp.ts_ls.setup({
						capabilities = capabilities,
						single_file_support = false,
						root_dir = lsp.util.root_pattern("package.json"),
					})
				end,
				["tailwindcss"] = function()
					lsp.tailwindcss.setup({
						capabilities = capabilities,
						root_dir = lsp.util.root_pattern(
							"tailwind.config.js",
							"tailwind.config.cjs",
							"tailwind.config.ts",
							"tailwind.config.mjs"
						),
					})
				end,
			},
		})
	end,
}
