return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
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
		local harpoon = require("harpoon")
		harpoon:setup()

		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end)
		vim.keymap.set("n", "<C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		vim.keymap.set("n", "<C-h>", function()
			harpoon:list():select(1)
		end)
		vim.keymap.set("n", "<C-t>", function()
			harpoon:list():select(2)
		end)
		vim.keymap.set("n", "<C-n>", function()
			harpoon:list():select(3)
		end)
		vim.keymap.set("n", "<C-s>", function()
			harpoon:list():select(4)
		end)
	end,
}
