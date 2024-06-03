return {
    {
        "camspiers/snap",
        keys = function()
            local snap = require("snap")
            return {
                { "<leader>f", snap.config.file({ producer = "ripgrep.file" }) },
                { "<leader>g", snap.config.vimgrep({}) },
            }
        end,
    },
    {
        "ggandor/leap.nvim",
        config = function() require("leap").create_default_mappings() end,
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = "nvim-lua/plenary.nvim",
        keys = function()
            local harpoon = require("harpoon")
            return {
                { "<C-e>", function() harpoon:list():add() end },
                { "<C-m>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end },
                { "<C-t>", function() harpoon:list():select(1) end },
                { "<C-g>", function() harpoon:list():select(2) end },
                { "<C-h>", function() harpoon:list():select(3) end },
                { "<C-y>", function() harpoon:list():select(4) end },
            }
        end,
        opts = { settings = { save_on_toggle = true } },
    },
}
