require("nvim-treesitter.configs").setup {
  ensure_installed = { "lua", "vim", "help", "query", "c", "cpp", "python", "haskell", "rust" },

  sync_install = true,
  auto_install = false,

  highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },

  incremental_selection = {
    enable = true,
    keymaps = {
        init_selection = "<c-space>",
        node_incremental = "<c-space>",
        node_decremental = "<c-z>",
    },
  },

  textobjects = {
    select = {
        enable = true,
        lookahead = true,
        include_surrounding_whitespace = true,
        keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
        },
    },

    move = {
        enable = true,
        set_jumps = true,
    goto_next_start = {
        ["]m"] = "@function.outer",
        ["]c"] = "@class.outer",
        ["]l"] = "@loop.outer",
     },
    goto_next_end = {
        ["]M"] = "@function.outer",
        ["]C"] = "@class.outer",
        ["]L"] = "@loop.outer",
    },
    goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[c"] = "@class.outer",
        ["[l"] = "@loop.outer",
    },
    goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[C"] = "@class.outer",
        ["[L"] = "@loop.outer",
    },
    goto_next = {
        ["]i"] = "@conditional.outer",
    },
    goto_previous = {
        ["[i"] = "@conditional.outer",
    },
    },

    swap = {
    enable = true,
    swap_next = {
        ["<leader>s"] = "@parameter.inner",
    },
    swap_previous = {
        ["<leader>S"] = "@parameter.inner",
    },
    },
  },
}

local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
