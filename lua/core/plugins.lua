local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Theme
    {
        "rebelot/kanagawa.nvim", lazy = false, priority = 1000,
        opts = {},
        config = function() vim.cmd("colorscheme kanagawa-wave") end,
    },
    -- Lua library
    { "nvim-lua/plenary.nvim", lazy = true, },
    -- Blazingly fast file navigation
    {
        "ThePrimeagen/harpoon",
        keys = {
            { "<C-e>", desc = "Add file to menu" },
            { "<C-m>", desc = "Toggle menu" },
            { "<C-t>", desc = "Go to 1st file" },
            { "<C-g>", desc = "Go to 2nd file" },
            { "<C-h>", desc = "Go to 3rd file" },
            { "<C-y>", desc = "Go to 4th file" },
        },
        config = function()
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")
            vim.keymap.set("n", "<C-e>", mark.add_file)
            vim.keymap.set("n", "<C-m>", ui.toggle_quick_menu)
            vim.keymap.set("n", "<C-t>", function() ui.nav_file(1) end)
            vim.keymap.set("n", "<C-g>", function() ui.nav_file(2) end)
            vim.keymap.set("n", "<C-h>", function() ui.nav_file(3) end)
            vim.keymap.set("n", "<C-y>", function() ui.nav_file(4) end)
        end,
    },
    -- Fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        keys = {
            { "<leader>ff", desc = "Find files by name" },
            { "<leader>fg", desc = "Find files by content" },
            { "<leader>fc", desc = "Find command in history" },
            { "<leader>fh", desc = "Find nvim help" },
        },
        dependencies = {
            "nvim-telescope/telescope-fzf-native.nvim", build = "make",
        },
        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
            vim.keymap.set("n", "<leader>fc", builtin.command_history, {})
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
            require("telescope").load_extension("fzf")
        end,
    },
    -- Icons
    { "nvim-tree/nvim-web-devicons", lazy = true, },
    -- Status line
    {
        "nvim-lualine/lualine.nvim", event = "VeryLazy", opts = {},
    },
    -- Auto pairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = { map_cr = true, },
    },
})
