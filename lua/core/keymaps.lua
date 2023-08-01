local key = vim.keymap.set
local opts = { noremap = true, silent = true }

key("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

key("i", "jj", "<Esc>", opts)
key("i", "jk", "<Esc>", opts)

key("n", "L", "<Cmd>bnext<CR>", opts)
key("n", "H", "<Cmd>bprev<CR>", opts)

key("v", "<", "<gv", opts)
key("v", ">", ">gv", opts)
