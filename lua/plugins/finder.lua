return {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = function()
        local builtin = require("telescope.builtin")
        return {
            { "<leader>ff", builtin.find_files, desc = "Find files by name" },
            { "<leader>fg", builtin.live_grep, desc = "Find files by content" },
            { "<leader>fm", builtin.man_pages, desc = "Find man pages" },
            { "<leader>fh", builtin.help_tags, desc = "Find nvim help" },
        }
    end,
    dependencies = {
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function() require("telescope").load_extension("fzf") end,
}
