-- General NVIM configs
vim.opt.isfname:append("@-@")
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Cursors and Scrolling Pad
vim.opt.guicursor = ""
vim.opt.scrolloff = 8

-- Terminal Colors, Sign Columns, and Text Wrapping
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false

-- Numberline configs
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 1

-- Tabbing and Indentations
vim.opt.tabstop = 4
vim.opt.softtabstop = -1
vim.opt.shiftwidth = 0
vim.opt.expandtab = true
vim.opt.smartindent = true

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
	command = "setlocal tabstop=2",
})

-- Diagnostic Configs
vim.diagnostic.config({
	update_in_insert = true,
	severity_sort = true,
	virtual_text = { source = "if_many", prefix = "●" },
	float = { source = "if_many", border = "rounded", header = "", prefix = "" },
})

vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError", numhl = "" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn", numhl = "" })
vim.fn.sign_define("DiagnosticSignHint", { text = "⚑", texthl = "DiagnosticSignHint", numhl = "" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "»", texthl = "DiagnosticSignInfo", numhl = "" })
