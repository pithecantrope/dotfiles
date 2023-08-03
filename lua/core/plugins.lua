local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Theme
    {
        "rebelot/kanagawa.nvim", lazy = false, priority = 1000, opts = {},
        config = function() require("kanagawa").load("wave") end
    },
    -- Lua library
    { "nvim-lua/plenary.nvim", lazy = true, },
    -- Blazingly fast file navigation
    {
        "ThePrimeagen/harpoon",
        keys = {
            { "<C-e>", desc = "Add file to menu" },
            { "<C-m>", desc = "Toggle menu" },
            { "<C-t>", desc = "Go to 1st file" },
            { "<C-g>", desc = "Go to 2nd file" },
            { "<C-h>", desc = "Go to 3rd file" },
            { "<C-y>", desc = "Go to 4th file" },
        },
        config = function()
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")
            vim.keymap.set("n", "<C-e>", mark.add_file)
            vim.keymap.set("n", "<C-m>", ui.toggle_quick_menu)
            vim.keymap.set("n", "<C-t>", function() ui.nav_file(1) end)
            vim.keymap.set("n", "<C-g>", function() ui.nav_file(2) end)
            vim.keymap.set("n", "<C-h>", function() ui.nav_file(3) end)
            vim.keymap.set("n", "<C-y>", function() ui.nav_file(4) end)
        end,
    },
    -- Fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        keys = {
            { "<leader>ff", desc = "Find files by name" },
            { "<leader>fg", desc = "Find files by content" },
            { "<leader>fc", desc = "Find command in history" },
            { "<leader>fh", desc = "Find nvim help" },
        },
        dependencies = {
            "nvim-telescope/telescope-fzf-native.nvim", build = "make",
        },
        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
            vim.keymap.set("n", "<leader>fc", builtin.command_history, {})
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
            require("telescope").load_extension("fzf")
        end,
    },
    -- Icons
    { "nvim-tree/nvim-web-devicons", lazy = true, },
    -- Status line
    {
        "nvim-lualine/lualine.nvim", event = "VeryLazy", opts = {},
    },
    -- Auto pairs
    { "windwp/nvim-autopairs", event = "InsertEnter", opts = {}, },
    -- Almighty syntax, smart selection, context and
    -- new text objects (class, function, call, parameter)
    {
        "nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" }, cmd = { "TSUpdateSync" },
        keys = {
            { "<C-space>", desc = "Increment selection" },
            { "<bs>", mode = "x", desc = "Decrement selection" },
            { "<leader>a", desc = "Swap argument forward" },
            { "<leader>A", desc = "Swap argument back" },
        },
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            { "nvim-treesitter/nvim-treesitter-context", opts = {}, },
        },
        opts = {
            auto_install = false,
            highlight = {
                enable = true, additional_vim_regex_highlighting = false,
            },
            indent = { enable = true },
            ensure_installed = {
                "bash", "json", "yaml", "query",
                "vim", "vimdoc", "lua", "luadoc", "luap",
                "markdown", "markdown_inline",
                "python", "regex",
                "c", "cpp",
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
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
    -- 
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "williamboman/mason.nvim", opts = {} },
            {
                "williamboman/mason-lspconfig.nvim",
                opts = {
                    ensure_installed = {
                        "lua_ls", "clangd", "pyright",
                    },
                },
            },
            { "folke/neodev.nvim", opts = {} },
            "hrsh7th/cmp-nvim-lsp",
        },
        opts = {
            -- !
        },
        config = function()
            local lspconfig = require('lspconfig')
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            lspconfig.lua_ls.setup {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        workspace = {
                            checkThirdParty = false,
                        },
                        completion = {
                            callSnippet = "Replace",
                        },
                    },
                },
            }
            lspconfig.pyright.setup { capabilities = capabilities, }
            lspconfig.clangd.setup { capabilities = capabilities, }
        end,
    },
    -- Powerful completion
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
        },
        opts = function()
            local cmp = require("cmp")
            return {
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-n>"] = cmp.mapping.select_next_item({
                        behavior = cmp.SelectBehavior.Insert
                    }),
                    ["<C-p>"] = cmp.mapping.select_prev_item({
                        behavior = cmp.SelectBehavior.Insert
                    }),
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                }),
                formatting = {
                    format = function(_, item)
                        local icons = require("core.config").kinds
                        item.kind = (icons[item.kind] or "") .. item.kind
                        return item
                    end,
                },
            }
        end,
    },
    -- Snippets
    {
        "L3MON4D3/LuaSnip", lazy = true, build = "make install_jsregexp",
        dependencies = {
            "rafamadriz/friendly-snippets",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end,
        },
        config = function()
            local ls = require("luasnip")
            vim.keymap.set({"i"}, "<C-l>",
                function() ls.expand() end, {silent = true})
            vim.keymap.set({"i", "s"}, "<C-j>",
                function() ls.jump( 1) end, {silent = true})
            vim.keymap.set({"i", "s"}, "<C-k>",
                function() ls.jump(-1) end, {silent = true})
        end
    },
    -- Commenting
    {
        'numToStr/Comment.nvim', opts = {},
        keys = {
            { "gcc", desc = "Line-comment toggle" },
            { "gbc", desc = "Block-comment toggle" },
            { "gcO", desc = "Add comment on the line above" },
            { "gco", desc = "Add comment on the line below" },
            { "gcA", desc = "Add comment at the end of line" },
        },
    },
})
