return {
	"theprimeagen/harpoon",
	keys = {
		{
			"<leader>a",
			desc = "Add a file to harpoon stash",
			mode = "n",
		},
		{
			"<C-e>",
			desc = "Open harpoon stash",
			mode = "n",
		},
		{
			"<C-h>",
			desc = "Goto harpooned file 1",
			mode = "n",
		},
		{
			"<C-t>",
			desc = "Goto harpooned file 2",
			mode = "n",
		},
		{
			"<C-n>",
			desc = "Goto harpooned file 3",
			mode = "n",
		},
		{
			"<C-s>",
			desc = "Goto harpooned file 4",
			mode = "n",
		},
	},
	config = function()
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		vim.keymap.set("n", "<leader>a", mark.add_file)
		vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

		vim.keymap.set("n", "<C-h>", function()
			ui.nav_file(1)
		end)
		vim.keymap.set("n", "<C-t>", function()
			ui.nav_file(2)
		end)
		vim.keymap.set("n", "<C-n>", function()
			ui.nav_file(3)
		end)
		vim.keymap.set("n", "<C-s>", function()
			ui.nav_file(4)
		end)
	end,
}
