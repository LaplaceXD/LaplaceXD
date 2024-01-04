return {
	{
		"andweeb/presence.nvim",
		event = "VeryLazy",
		opts = { main_image = "file" },
	},

	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_combine_preview = 1
			vim.g.mkdp_auto_close = 0

			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},

	{
		"0x00-ketsu/autosave.nvim",
		event = { "CursorHold", "CursorHoldI", "BufLeave", "FocusLost", "ExitPre" },
		opts = {
			events = {
				-- Save when cursor doesn't move until updatetime expires (4s default)
				"CursorHold",
				"CursorHoldI",
				-- Save when changing or leaving buffers, or when losing focus to the buffer
				"BufLeave",
				"FocusLost",
				-- Save before exiting vim
				"ExitPre",
			},
		},
	},

	{
		"mbbill/undotree",
		keys = {
			{ "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree", mode = "n" },
		},
	},

	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<leader>xw", desc = "Toggle Trouble Workspace", mode = "n" },
			{ "<leader>xd", desc = "Toggle Trouble Document", mode = "n" },
			{ "<leader>xr", desc = "Toggle Trouble LSP references", mode = "n" },
			{ "]]", desc = "Next Trouble Item", mode = "n" },
			{ "[[", desc = "Previous Trouble Item", mode = "n" },
		},
		config = function()
			local trouble = require("trouble")

			vim.keymap.set("n", "<leader>xw", function()
				trouble.toggle("workspace_diagnostics")
			end)
			vim.keymap.set("n", "<leader>xd", function()
				trouble.toggle("document_diagnostics")
			end)
			vim.keymap.set("n", "<leader>xr", function()
				trouble.toggle("lsp_references")
			end)

			vim.keymap.set("n", "]]", function()
				trouble.next({ skip_groups = true, jump = true })
			end)
			vim.keymap.set("n", "[[", function()
				trouble.previous({ skip_groups = true, jump = true })
			end)
		end,
	},

	{
		"tpope/vim-fugitive",
		cmd = { "Git" },
		keys = {
			{ "<leader>gs", "<cmd>Git<cr>", desc = "Toggle Git", mode = "n" },
		},
	},

	{
		"lewis6991/gitsigns.nvim",
		opts = { current_line_blame_opts = { delay = 250 } },
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{
				"<leader>gb",
				"<cmd>Gitsigns toggle_current_line_blame<cr>",
				desc = "Toggle Current Line Blame",
				mode = "n",
			},
		},
	},
}
