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
		"Pocco81/auto-save.nvim",
		event = { "InsertLeave", "FocusLost", "VimLeavePre" },
		opts = { trigger_events = { "InsertLeave", "FocusLost", "VimLeavePre" } },
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
			{ "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Toggle Trouble", mode = "n" },
		},
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
