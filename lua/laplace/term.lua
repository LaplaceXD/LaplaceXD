vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 1

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.api.nvim_create_augroup("setIndent", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = "setIndent",
	pattern = {
		"html",
		"css",
		"scss",
		"yaml",
		"toml",
		"json",
		"markdown",
		"md",
		"typescript",
		"typescriptreact",
		"javascript",
		"javascriptreact",
		"jsx",
		"tsx",
	},
	command = "setlocal shiftwidth=2 softtabstop=2 tabstop=2",
})

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.diagnostic.config({
	virtual_text = {
		source = "if_many",
		prefix = "●",
	},
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "if_many",
		header = "",
		prefix = "",
	},
})
