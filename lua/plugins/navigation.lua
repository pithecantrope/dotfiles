return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = function()
        local harpoon = require("harpoon")
        return {
            { "<C-e>", function() harpoon:list():add() end, desc = "Tag a harpoon file" },
            {
                "<C-m>",
                function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
                desc = "Toggle harpoon menu",
            },
            { "<C-t>", function() harpoon:list():select(1) end, desc = "Select 1st harpoon file" },
            { "<C-g>", function() harpoon:list():select(2) end, desc = "Select 2nd harpoon file" },
            { "<C-h>", function() harpoon:list():select(3) end, desc = "Select 3rd harpoon file" },
            { "<C-y>", function() harpoon:list():select(4) end, desc = "Select 4th harpoon file" },
        }
    end,
    config = function() require("harpoon"):setup({}) end,
}
