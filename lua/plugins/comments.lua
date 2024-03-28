return {
    {
        "numToStr/Comment.nvim",
        keys = {
            { "gc", mode = { "n", "x" }, desc = "Line-comment toggle" },
            { "gb", mode = { "n", "x" }, desc = "Block-comment toggle" },
            -- gcc - Line-comment toggle line
            -- gbc - Block-comment toggle line
            -- gcO - Add comment on the line above
            -- gco - Add comment on the line below
            -- gcA - Add comment at the end of line
        },
        opts = {},
    },
    {
        "folke/todo-comments.nvim",
        opts = {},
        config = function(_, opts)
            local todo = require("todo-comments")
            todo.setup(opts)

            vim.keymap.set("n", "]t", todo.jump_next, { desc = "Next todo comment" })
            vim.keymap.set("n", "[t", todo.jump_prev, { desc = "Previous todo comment" })
            vim.keymap.set("n", "<leader>lt", ":TodoQuickFix<Enter>", { desc = "List todo comments" })
            vim.keymap.set("n", "<leader>ft", ":TodoTelescope<Enter>", { desc = "Find todo comments" })
        end,
    },
}
