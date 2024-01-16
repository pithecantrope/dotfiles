return {
    {
        "numToStr/Comment.nvim",
        keys = {
            { "gc", mode = { "n", "x" }, desc = "Line-comment toggle" },
            { "gb", mode = { "n", "x" }, desc = "Block-comment toggle" },
            { "gcc", desc = "Line-comment toggle line" },
            { "gbc", desc = "Block-comment toggle line" },
            { "gcO", desc = "Add comment on the line above" },
            { "gco", desc = "Add comment on the line below" },
            { "gcA", desc = "Add comment at the end of line" },
        },
        opts = {},
    },
    {
        "folke/todo-comments.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {},
        config = function(_, opts)
            local todo = require("todo-comments")
            todo.setup(opts)
            vim.keymap.set("n", "<leader>lt", "<cmd>TodoLocList<CR>", { desc = "List comments" })
        end,
    },
}
