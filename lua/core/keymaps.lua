local set = vim.keymap.set

set({ "n", "i", "v" }, "<Up>", "<Nop>")
set({ "n", "i", "v" }, "<Down>", "<Nop>")
set({ "n", "i", "v" }, "<Left>", "<Nop>")
set({ "n", "i", "v" }, "<Right>", "<Nop>")
set("i", "<C-c>", "<Esc>")
set("n", "<CR>", "<Return>")

set("n", "J", "mzJ`z")
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")
set("n", "n", "nzz")
set("n", "N", "Nzz")

set("n", "<C-j>", "<cmd>cnext<CR>zz")
set("n", "<C-k>", "<cmd>cprev<CR>zz")
set("n", "<C-l>", "<cmd>lnext<CR>zz")
set("n", "<C-;>", "<cmd>lprev<CR>zz")

vim.g.mapleader = " "

set({ "n", "v" }, "<leader>d", [["_d]])
set("n", "<leader>df", [[gg"_dG]])

set({ "n", "v" }, "<leader>y", [["+y]])
set("n", "<leader>Y", [["+y$]])
set("n", "<leader>yf", [[gg"+yG]])

set({ "n", "v" }, "<leader>p", [["+p]])
set({ "n", "v" }, "<leader>P", [["+P]])

set("n", "<leader>q", vim.cmd.Ex)
