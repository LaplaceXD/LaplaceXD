return {
	"echasnovski/mini.files",
	keys = {
		{ "<leader>d", "<cmd>lua MiniFiles.open()<cr>", desc = "Open File Tree", mode = "n" },
	},
	opts = {
		options = {
			use_as_default_explorer = false,
			permanent_delete = false,
		},
		mappings = {
			go_in = "L",
			go_in_plus = "l",
			go_out = "H",
			go_out_plus = "h",
		},
		windows = {
			preview = true,
			max_number = 4,
			width_focus = 25,
			width_nofocus = 25,
			width_preview = 50,
		},
	},
}
