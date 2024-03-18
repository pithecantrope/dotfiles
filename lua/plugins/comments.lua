return {
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
}
