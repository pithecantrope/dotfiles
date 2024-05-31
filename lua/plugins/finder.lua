return {
    "camspiers/snap",
    keys = function()
        local snap = require("snap")
        return {
            { "<leader>f", snap.config.file({ producer = "ripgrep.file" }) },
            { "<leader>g", snap.config.vimgrep({}) },
        }
    end,
}
