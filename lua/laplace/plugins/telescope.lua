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
			"<leader>d",
			desc = "Show open buffers for current session",
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
			"<leader>pws",
			desc = "Find references to the hovered word (up to a non-alphanumeric character)",
			mode = "n",
		},
		{
			"<leader>pWs",
			desc = "Find references to the hovered word (up to a whitespace)",
			mode = "n",
		},
		{
			"gr",
			desc = "Find lsp token references with telescope preview",
			mode = "n",
		},
		{
			"gi",
			desc = "Find lsp token implementations with telescope preview",
			mode = "n",
		},
		{
			"<leader>ws",
			desc = "Find lsp token workspace symbols with telescope preview",
			mode = "n",
		},
	},
	config = function()
		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>d", builtin.buffers)
		vim.keymap.set("n", "<leader>pf", builtin.find_files)
		vim.keymap.set("n", "<leader>pws", function()
			builtin.grep_string({ search = vim.fn.expand("<cword>") })
		end)
		vim.keymap.set("n", "<leader>pWs", function()
			builtin.grep_string({ search = vim.fn.expand("<cWORD>") })
		end)
		vim.keymap.set("n", "<leader>ps", function()
			vim.ui.input({ prompt = "Search > " }, function(search)
				builtin.grep_string({ search = search })
			end)
		end)
		vim.keymap.set("n", "<C-p>", function()
			builtin.git_files({ show_untracked = true })
		end)

		vim.api.nvim_create_autocmd("LspAttach", {
			desc = "LSP Actions powered with Telescope",
			callback = function(args)
				local lsp_opts = { buffer = args.buf, remap = false }
				local client = vim.lsp.get_client_by_id(args.data.client_id)

				if client.supports_method("textDocument/references") then
					vim.keymap.set("n", "gr", function()
						builtin.lsp_references({
							include_declaration = false,
							show_line = false,
							trim_text = true,
						})
					end, lsp_opts)
				end

				if client.supports_method("textDocument/implementation") then
					vim.keymap.set("n", "gi", function()
						builtin.lsp_implementations({ trim_text = true })
					end, lsp_opts)
				end

				if client.supports_method("workspace/symbol") then
					vim.keymap.set("n", "<leader>ws", function()
						vim.ui.input({ prompt = "Symbol > " }, function(query)
							builtin.lsp_workspace_symbols({ query = query })
						end)
					end, lsp_opts)
				end
			end,
		})
	end,
}
