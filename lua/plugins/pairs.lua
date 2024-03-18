return {
    {
        "altermo/ultimate-autopair.nvim",
        event = { "InsertEnter", "CmdlineEnter" },
        opts = {},
    },
    {
        "kylechui/nvim-surround",
        keys = {
            { "ys", desc = "Add surround" },
            { "yS", desc = "Add surround on new lines" },
            -- yss, ySS - Current line
            { "cs", desc = "Change surround" },
            { "ds", desc = "Delete surround" },
            { "<C-s>", mode = "x", desc = "Add surround (visual)" },
            -- t - tag's type
            -- T - tag's content
            -- f - function call
            -- b - )
            -- r - ]
            -- q - {', ", `}
        },
        opts = {
            keymaps = {
                visual = "<C-s>",
            },
        },
    },
}
