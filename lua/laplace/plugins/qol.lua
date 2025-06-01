return {
	{ "andweeb/presence.nvim", event = "VeryLazy", opts = { main_image = "file" } },

	{
		"github/copilot.vim",
		cmd = { "Copilot" },
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{ "<S-Tab>", "copilot#Accept('<CR>')", expr = true, replace_keycodes = false, mode = "i" },
		},
	},

	{
		"0x00-ketsu/autosave.nvim",
		event = { "CursorHold", "CursorHoldI", "BufLeave", "FocusLost", "ExitPre" },
		opts = { events = { "CursorHold", "CursorHoldI", "BufLeave", "FocusLost", "ExitPre" } },
	},

	{
		"mbbill/undotree",
		keys = {
			{ "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree", mode = "n" },
		},
	},

	{
		"tpope/vim-fugitive",
		cmd = { "G", "Git" },
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

	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewFileHistory" },
		keys = {
			{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview", mode = "n" },
			{ "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "Open Diffview File History", mode = "n" },
			{ "<leader>gg", "<cmd>DiffviewClose<cr>", desc = "Close Diffview", mode = "n" },
		},
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
		"chomosuke/typst-preview.nvim",
		cmd = { "TypstPreview", "TypstPreviewUpdate", "TypstPreviewToggle" },
		opts = {},
		ft = { "typst" },
		version = "1.*",
	},

	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<leader>xx", desc = "Toggle Trouble Workspace", mode = "n" },
			{ "<leader>xd", desc = "Toggle Trouble Document", mode = "n" },
			{ "<leader>xr", desc = "Toggle Trouble LSP references", mode = "n" },
			{ "]]", desc = "Next Trouble Item", mode = "n" },
			{ "[[", desc = "Previous Trouble Item", mode = "n" },
		},
		config = function()
			local trouble = require("trouble")

			vim.keymap.set("n", "<leader>xx", function()
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
}
