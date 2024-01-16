return {
    "ThePrimeagen/harpoon",
    keys = function()
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")
        return {
            { "<C-e>", mark.add_file, desc = "Add file to menu" },
            { "<C-m>", ui.toggle_quick_menu, desc = "Toggle menu" },
            { "<C-t>", function() ui.nav_file(1) end, desc = "Go to 1st file" },
            { "<C-g>", function() ui.nav_file(2) end, desc = "Go to 2nd file" },
            { "<C-h>", function() ui.nav_file(3) end, desc = "Go to 3rd file" },
            { "<C-y>", function() ui.nav_file(4) end, desc = "Go to 4th file" },
        }
    end,
}
