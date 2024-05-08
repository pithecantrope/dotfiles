return {
    { "nvim-lua/plenary.nvim", lazy = true },
    { "nvim-tree/nvim-web-devicons", lazy = true },
    {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        lazy = true,
        config = function()
            local ls = require("luasnip")
            vim.keymap.set({ "i", "s" }, "<C-j>", function() ls.jump(1) end, {
                silent = true,
                desc = "Jump forward snippet",
            })
            vim.keymap.set({ "i", "s" }, "<C-k>", function() ls.jump(-1) end, {
                silent = true,
                desc = "Jump backward snippet",
            })
        end,
    },
}
