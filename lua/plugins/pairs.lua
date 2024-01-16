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
            { "cs", desc = "Change surround" },
            { "ds", desc = "Delete surround" },
            { "gs", mode = "x", desc = "Add surround (visual)" },
        },
        opts = {
            keymaps = {
                visual = "gs",
            },
        },
    },
}
