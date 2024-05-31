vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<Enter>", "<Return>")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<C-l>", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<C-;>", "<cmd>lprev<CR>zz")

vim.keymap.set({ "i", "s" }, "<C-j>", function() vim.snippet.jump(1) end)
vim.keymap.set({ "i", "s" }, "<C-k>", function() vim.snippet.jump(-1) end)

vim.g.mapleader = " "

vim.keymap.set("n", "<leader>,", "mzA,<Esc>`z")
vim.keymap.set("n", "<leader>;", "mzA;<Esc>`z")
vim.keymap.set("n", "<leader>\\", "mzA\\<Esc>`z")

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]])
vim.keymap.set({ "n", "v" }, "<leader>P", [["+P]])
vim.keymap.set("n", "<leader>x", [[gg"_dG]])
vim.keymap.set("n", "<leader>w", [[gg"+yG]])

vim.keymap.set("n", "<leader>q", vim.cmd.Ex)
