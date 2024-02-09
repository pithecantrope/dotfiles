require("core.options")
require("core.keymaps")

-- Neovide
if vim.g.neovide then
    vim.o.guifont = "JetBrains Mono:h13"
    vim.opt.linespace = 2
    vim.g.neovide_fullscreen = true
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_padding_left = 256
else
    vim.opt.numberwidth = 20
end

-- Bootstrap lazy
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

require("lazy").setup("plugins", {
    change_detection = {
        enabled = true,
        notify = false,
    },
    ui = {
        border = "rounded",
    },
})
