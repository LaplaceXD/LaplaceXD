return {
	"neovim/nvim-lspconfig",
	event = "BufEnter",
	cmd = { "Mason" },
	build = ":MasonUpdate",
	dependencies = {
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		require("mason").setup({ ui = { border = "rounded" } })

		vim.lsp.config("*", {
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		})

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					diagnostics = { globals = { "vim" } },
					workspace = { library = { vim.env.VIMRUNTIME } },
				},
			},
		})

		vim.lsp.config("vtsls", {
			single_file_support = false,
			root_dir = function(bufnr, cb)
				local deno_dir = vim.fs.root(bufnr, { "deno.json", "deno.jsonc", "deno.lock" })
				local node_dir = vim.fs.root(bufnr, {
					"package.json",
					"tsconfig.json",
					"jsconfig.json",
					"bun.lockb",
					"bun.lock",
				})

				if node_dir and deno_dir == nil then
					cb(node_dir)
				end
			end,
		})

		require("mason-lspconfig").setup({
			ensure_installed = {
				-- Core language servers
				"clangd", -- C/C++
				"gopls", -- Go
				"pyright", -- Python
				"lua_ls", -- Lua
				"denols", -- Deno
				"rust_analyzer", -- Rust
				-- Front-end / web
				"html", -- HTML
				"cssls", -- CSS
				"tailwindcss", -- Tailwind utility classes
				"vtsls", -- TypeScript & JavaScript (for non-Deno projects)
				-- Extras you almost always want
				"jsonls", -- JSON schemas & validation
				"yamlls", -- YAML (e.g. GitHub Actions, K8s manifests)
				"bashls", -- Bash scripts
				"dockerls", -- Dockerfile
			},
		})
	end,
}
