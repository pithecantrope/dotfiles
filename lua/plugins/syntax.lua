return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        {
            "nvim-treesitter/nvim-treesitter-context",
            keys = {
                {
                    "<leader>c",
                    function() require("treesitter-context").go_to_context() end,
                    desc = "Jump to context",
                },
            },
            opts = {
                mode = "cursor",
                max_lines = 3,
            },
        },
    },
    opts = {
        auto_install = false,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        ensure_installed = {
            "bash",
            "toml",
            "json",
            "yaml",
            "query",
            "sql",
            "vim",
            "vimdoc",
            "lua",
            "luadoc",
            "luap",
            "markdown",
            "markdown_inline",
            "python",
            "regex",
            "c",
            "make",
            "doxygen",
            "cpp",
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-space>",
                node_incremental = "<C-space>",
                scope_incremental = false,
                node_decremental = "<bs>",
            },
        },
        textobjects = {
            move = {
                enable = true,
                goto_next_start = { ["]f"] = "@function.outer", ["]o"] = "@class.outer" },
                goto_next_end = { ["]F"] = "@function.outer", ["]O"] = "@class.outer" },
                goto_previous_start = { ["[f"] = "@function.outer", ["[o"] = "@class.outer" },
                goto_previous_end = { ["[F"] = "@function.outer", ["[O"] = "@class.outer" },
            },
            select = {
                enable = true,
                lookahead = true,
                include_surrounding_whitespace = true,
                keymaps = {
                    ["ao"] = "@class.outer",
                    ["io"] = "@class.inner",
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@call.outer",
                    ["ic"] = "@call.inner",
                    ["aa"] = "@parameter.outer",
                    ["ia"] = "@parameter.inner",
                },
            },
            swap = {
                enable = true,
                swap_next = {
                    ["<leader>a"] = "@parameter.inner",
                },
                swap_previous = {
                    ["<leader>A"] = "@parameter.inner",
                },
            },
        },
    },
    config = function(_, opts) require("nvim-treesitter.configs").setup(opts) end,
}
