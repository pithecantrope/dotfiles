local builtin = require("telescope.builtin")
-- Find
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fw", builtin.grep_string, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fc", builtin.command_history, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>fk", builtin.keymaps, {})
-- Lsp search

require("telescope").load_extension("fzf")
