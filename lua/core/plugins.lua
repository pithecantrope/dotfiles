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
        "rebelot/kanagawa.nvim", lazy = false, priority = 1000,
        config = function() require("core.config.colorscheme") end,
    },
    -- Lua library
    { "nvim-lua/plenary.nvim", lazy = true, },
    -- Blazingly fast file navigation
    {
        "ThePrimeagen/harpoon", lazy = false,
        config = function() require("core.config.harpoon") end,
    },
    -- Fuzzy finder
    {
        "nvim-telescope/telescope.nvim", lazy = false,
        dependencies = {
            "nvim-telescope/telescope-fzf-native.nvim", build = "make",
        },
        config = function() require("core.config.telescope") end,
    },
    -- Icons
    { "nvim-tree/nvim-web-devicons", lazy = true, },
    -- Status line
    {
        "nvim-lualine/lualine.nvim", event = "VeryLazy",
        config = function() require("core.config.lualine") end,
    },
}
local opts = {}

require("lazy").setup(plugins, opts)
