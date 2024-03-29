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
				"lua_ls",
				"gopls",
				"tsserver",
				"html",
				"cssls",
				"tailwindcss",
				"pyright",
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
				["clangd"] = function()
					lsp.clangd.setup({
						-- Need to setup %UserProfile%/AppData/Local/clangd/config.yaml as well
						-- CompileFlags:
						--   Compiler: <same-as-query-driver>
						capabilities = capabilities,
						cmd = {
							"clangd",
							"--query-driver=C:\\dev\\msys64\\ucrt64\\bin\\gcc,C:\\dev\\msys64\\ucrt64\\bin\\g++",
						},
					})
				end,
			},
		})
	end,
}
