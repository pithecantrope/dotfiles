return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        on_attach = function(bufnr)
            local git = require("gitsigns")

            vim.keymap.set("n", "]h", function() git.nav_hunk("next") end, { buffer = bufnr })
            vim.keymap.set("n", "[h", function() git.nav_hunk("prev") end, { buffer = bufnr })
            vim.keymap.set("n", "]H", function() git.nav_hunk("last") end, { buffer = bufnr })
            vim.keymap.set("n", "[H", function() git.nav_hunk("first") end, { buffer = bufnr })

            vim.keymap.set("n", "<leader>hs", git.stage_hunk, { buffer = bufnr })
            vim.keymap.set("n", "<leader>hr", git.reset_hunk, { buffer = bufnr })
            vim.keymap.set("n", "<leader>hS", git.stage_buffer, { buffer = bufnr })
            vim.keymap.set("n", "<leader>hR", git.reset_buffer, { buffer = bufnr })
            vim.keymap.set("n", "<leader>hp", git.preview_hunk_inline, { buffer = bufnr })
            vim.keymap.set("n", "<leader>hd", git.diffthis, { buffer = bufnr })
        end,
    },
}
