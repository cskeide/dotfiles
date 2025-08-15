local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Split navigation with Ctrl + h/j/k/l
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)
