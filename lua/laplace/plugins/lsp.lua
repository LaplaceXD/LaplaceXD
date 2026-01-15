return {
	"neovim/nvim-lspconfig",
	event = "BufEnter",
	cmd = { "Mason" },
	build = ":MasonUpdate",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		require("mason").setup({ ui = { border = "rounded" } })

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					diagnostics = { globals = { "vim" } },
					workspace = { library = { vim.env.VIMRUNTIME } },
				},
			},
		})

		vim.lsp.config("denols", {
			root_dir = function(_, cb)
				local deno_dir = vim.fs.root(0, { "deno.json", "deno.jsonc" })

				if deno_dir then
					cb(deno_dir)
				end
			end,
		})

		vim.lsp.config("vtsls", {
			single_file_support = false,
			root_dir = function(_, cb)
				local deno_dir = vim.fs.root(0, { "deno.json", "deno.jsonc" })
				local node_dir = vim.fs.root(0, { "package.json", "tsconfig.json", "bun.lockb", "jsconfig.json" })

				if node_dir and deno_dir == nil then
					cb(node_dir)
				end
			end,
		})

		vim.lsp.config("tailwindcss", {
			root_dir = vim.fs.root(0, {
				"tailwind.config.js",
				"tailwind.config.cjs",
				"tailwind.config.ts",
				"tailwind.config.mjs",
			}),
		})

		require("mason-lspconfig").setup({
			ensure_installed = {
				-- Core language servers
				"clangd", -- C/C++
				"gopls", -- Go
				"pyright", -- Python
				"lua_ls", -- Lua
				"denols", -- Deno
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
