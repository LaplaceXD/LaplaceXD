return {
	{
		"kylechui/nvim-surround",
		keys = {
			{ "ys", desc = "Insert surrounding character command prefix.", mode = "n" },
			{ "cs", desc = "Change surrounding character command prefix.", mode = "n" },
			{ "ds", desc = "Delete surrounding character command prefix.", mode = "n" },
		},
		opts = {},
	},

	{
		"windwp/nvim-autopairs",
		event = { "BufReadPre", "BufNewFile" },
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
