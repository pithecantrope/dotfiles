return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        signs = {
            add = { text = "▎" },
            change = { text = "▎" },
            delete = { text = "" },
            topdelete = { text = "" },
            changedelete = { text = "▎" },
            untracked = { text = "▎" },
        },
        on_attach = function(buffer)
            local gs = package.loaded.gitsigns
            local function map(mode, l, r, desc) vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc }) end

            map("n", "]h", gs.next_hunk, "Next hunk")
            map("n", "[h", gs.prev_hunk, "Prev hunk")
            map({ "n", "v" }, "ghs", ":Gitsigns stage_hunk<CR>", "Stage hunk")
            map({ "n", "v" }, "ghr", ":Gitsigns reset_hunk<CR>", "Reset hunk")
            map("n", "ghu", gs.undo_stage_hunk, "Undo stage hunk")
            map("n", "ghS", gs.stage_buffer, "Stage buffer")
            map("n", "ghR", gs.reset_buffer, "Reset buffer")
            map("n", "ghp", gs.preview_hunk, "Preview hunk")
            map("n", "ghb", function() gs.blame_line({ full = true }) end, "Blame line")
            map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select hunk")
        end,
    },
}
