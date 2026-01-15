return {
	{
		"kylechui/nvim-surround",
		keys = {
			{ "ys", desc = "Insert surrounding character command prefix.", mode = "n" },
			{ "yss", desc = "Insert surrounding character on the current line command prefix.", mode = "n" },
			{ "S", desc = "Insert surrounding character on the selection command prefix.", mode = "n" },
			{ "cs", desc = "Change surrounding character command prefix.", mode = "n" },
			{ "cS", desc = "Change surrounding character and put changes on new lines command prefix.", mode = "n" },
			{ "ds", desc = "Delete surrounding character command prefix.", mode = "n" },
		},
		opts = {},
	},

	{
		"windwp/nvim-autopairs",
		event = "BufEnter",
		opts = {},
	},

	{
		"windwp/nvim-ts-autotag",
		ft = {
			"html",
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
			"svelte",
			"vue",
			"tsx",
			"jsx",
			"rescript",
			"xml",
			"php",
			"markdown",
			"astro",
			"glimmer",
			"handlebars",
			"hbs",
		},
		opts = {},
	},
}
