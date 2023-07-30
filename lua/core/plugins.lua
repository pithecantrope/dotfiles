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

local plugins = {
    -- Theme
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
    },
    -- Blazingly fast file navigation
    {
        "ThePrimeagen/harpoon",
        dependencies = "nvim-lua/plenary.nvim",
    },
    -- Fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        dependencies = "nvim-lua/plenary.nvim",
    },
    -- Finder algorithm
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

}
local opts = {}

require("lazy").setup(plugins, opts)
