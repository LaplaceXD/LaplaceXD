return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	opts = {
		ensure_installed = {
			"html",
			"css",
			"javascript",
			"typescript",
			"tsx",
			"go",
			"python",
			"c",
			"markdown",
			"markdown_inline",
			"json",
			"jsonc",
			"lua",
		},

		sync_install = false,
		auto_install = true,

		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
