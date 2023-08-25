vim.opt.mouse = ""
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = "88"
vim.opt.scrolloff = 8
vim.opt.wrap = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.list = true
vim.opt.listchars:append("eol:↴")

vim.opt.swapfile = false
vim.opt.fileformat = "unix"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.updatetime = 50

vim.wo.foldtext =
    [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'. trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
