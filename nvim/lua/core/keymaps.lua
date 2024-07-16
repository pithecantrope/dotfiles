vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")

vim.keymap.set({ "i", "s" }, "<C-j>", function() vim.snippet.jump(1) end)
vim.keymap.set({ "i", "s" }, "<C-k>", function() vim.snippet.jump(-1) end)
vim.keymap.set("n", "J", "mzJ`z")

vim.g.mapleader = " "

vim.keymap.set("x", "<leader>\"", [[c"<C-r>""<Esc>]])

vim.keymap.set({ "n", "x" }, "<leader>d", "\"_d")
vim.keymap.set({ "n", "x" }, "<leader>y", "\"+y")
vim.keymap.set({ "n", "x" }, "<leader>p", "\"+p")
vim.keymap.set({ "n", "x" }, "<leader>P", "\"+P")

vim.keymap.set("n", "<leader>z", "mzgg\"+yG`z")
vim.keymap.set("n", "<leader>x", "gg\"_dG")
vim.keymap.set("n", "<leader>q", vim.cmd.Ex)

-- 'ctrl x/ctrl f'
