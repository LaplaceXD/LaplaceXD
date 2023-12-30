return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"nvim-treesitter/nvim-treesitter",
	},
	keys = {
		{
			"<leader>pf",
			desc = "Find files within Project Directory",
			mode = "n",
		},
		{
			"<C-p>",
			desc = "Find Files within Git Directory",
			mode = "n",
		},
		{
			"<leader>ps",
			desc = "Find Files with a Search String in a Project Directory",
			mode = "n",
		},
		{
			"gd",
			desc = "Find lsp token definitions with telescope preview.",
			mode = "n",
		},
		{
			"gi",
			desc = "Find lsp token implementations with telescope preview.",
			mode = "n",
		},
		{
			"gr",
			desc = "Find lsp token references with telescope preview.",
			mode = "n",
		},
		{
			"<leader>ws",
			desc = "Find lsp token workspace symbols with telescope preview.",
			mode = "n",
		},
	},
	config = function()
		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>pf", function()
			builtin.find_files({ prompt_prefix = "🔍 " })
		end)
		vim.keymap.set("n", "<C-p>", function()
			builtin.git_files({ show_untracked = true, prompt_prefix = "🔍 " })
		end)
		vim.keymap.set("n", "<leader>ps", function()
			builtin.grep_string({ search = vim.fn.input("Search > "), prompt_prefix = "🔍 " })
		end)

		vim.api.nvim_create_autocmd("LspAttach", {
			desc = "LSP Actions powered with Telescope",
			callback = function(event)
				local keymaps = {
					{
						"textDocument/definition",
						"gd",
						function()
							builtin.lsp_definitions({ trim_text = true })
						end,
					},
					{
						"textDocument/references",
						"gr",
						function()
							builtin.lsp_references({
								include_declaration = false,
								jump_type = "never",
								show_line = false,
								trim_text = true,
							})
						end,
					},
					{
						"textDocument/implementation",
						"gi",
						function()
							builtin.lsp_definitions({ trim_text = true })
						end,
					},
					{
						"workspace/symbol",
						"<leader>ws",
						function()
							builtin.lsp_workspace_symbols({
								query = vim.fn.input("Symbol > "),
							})
						end,
					},
				}

				local lsp_opts = { buffer = event.buf, remap = false }
				local client = vim.lsp.get_active_clients()[1]

				-- unpack is still used in 5.1 which is used in nvim internally even though its deprecated
				table.unpack = table.unpack or unpack
				for _, mapping in ipairs(keymaps) do
					local method, key, action = table.unpack(mapping)

					if client.supports_method(method) then
						vim.keymap.set("n", key, action, lsp_opts)
					end
				end
			end,
		})
	end,
}
