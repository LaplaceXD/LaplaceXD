vim.g.mapleader = " "
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
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- Duplicate lines 
vim.keymap.set("n", "<C-d>", "yyp")
vim.keymap.set("i", "<C-d>", "<Esc>yypi")
vim.keymap.set("v", "<C-d>", "y'<Pgv")

-- Commenting lines
-- Unfortunately, this one was quite hard

-- Just removes spaces below a line
vim.keymap.set("n", "J", "mzJ`z")

-- Move to next search item, you need to use this in unison with :/<searchstring>
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Copy paste remap, wherein the remap actually replaces the highlighted content
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Copy to clipboard along with void register
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
-- The same but only for the current line
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Replace the hovered word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Open Packer File
vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/AppData/Local/nvim/lua/laplace/packer.lua<CR>");

-- Clearfix Movement 
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
