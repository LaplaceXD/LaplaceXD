vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "Q", "<nop>")

-- Shifting of items up and down thank god
-- This works for all normal, insertion, and selection modes
vim.keymap.set("n", "<A-Up>", ":m .-2<CR>==")
vim.keymap.set("n", "<A-Down>", ":m .+1<CR>==")
vim.keymap.set("i", "<A-Up>", "<Esc>:m .-2<CR>==gi")
vim.keymap.set("i", "<A-Down>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv")

-- Extra opts to make the below keybinds work, since
-- <Esc>j, and <Esc>k are interpreted as <A-j>, and <A-k>, respectively
-- if you move too fast
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 0

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi")
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")

-- Duplicate lines
vim.keymap.set("n", "<A-d>", "mayyp`aj:delmarks a<cr>")
vim.keymap.set("i", "<A-d>", "<esc>mayyp`aj:delmarks a<cr>i")
vim.keymap.set("v", "<A-d>", "y'<Pgv")

-- Indentation
vim.keymap.set("n", "<Tab>", ">>^")
vim.keymap.set("n", "<S-Tab>", "<<^")
vim.keymap.set("v", "<Tab>", ">gv^")
vim.keymap.set("v", "<S-Tab>", "<gv^")

-- Just removes spaces below a line
vim.keymap.set("n", "J", "mzJ`z")

-- Traversal in blocks while maintaining cursor position
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Move to next search item, you need to use this in unison with /<searchstring>
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Copy paste remap, wherein the previously copied item is kept in the register
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Copy to clipboard along with void register
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
-- The same but only for the current line
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Replace the hovered word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Open Lazy File
vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/laplace/lazy.lua<CR>")

-- Clearfix Movement
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Code Diagnostics
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end)
vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end)

-- LSP Keymaps
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP Actions",
	callback = function(args)
		--- @type [string, string, function][]
		local handlers = {
			{ "workspace/symbol", "<leader>ws", vim.lsp.buf.workspace_symbol },
			{
				"textDocument/hover",
				"K",
				function()
					vim.lsp.buf.hover({ border = "rounded", max_width = 80, max_height = 20 })
				end,
			},
			{ "textDocument/definition", "gd", vim.lsp.buf.definition },
			{ "textDocument/references", "gr", vim.lsp.buf.references },
			{ "textDocument/implementation", "gi", vim.lsp.buf.implementation },
			{ "textDocument/codeAction", "<leader>ca", vim.lsp.buf.code_action },
			{ "textDocument/rename", "<leader>rn", vim.lsp.buf.rename },
			{
				"textDocument/signatureHelp",
				"<leader>h",
				function()
					vim.lsp.buf.signature_help({ border = "rounded", max_width = 80, max_height = 20 })
				end,
			},
		}

		local opts = { buffer = args.buf, remap = false }
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		if client == nil then
			return
		end

		-- unpack is still used in 5.1 which is used in nvim internally even though its deprecated
		table.unpack = table.unpack or unpack
		for _, mapping in ipairs(handlers) do
			local method, key, action = table.unpack(mapping)

			if client:supports_method(method) then
				vim.keymap.set("n", key, action, opts)
			end
		end
	end,
})
