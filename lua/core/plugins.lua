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
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            compile = true, -- :KanagawaCompile
        },
        config = function(_, opts)
            local kanagawa = require("kanagawa")
            kanagawa.setup(opts)
            kanagawa.load("wave")
        end,
    },
    -- Helpful lua library
    { "nvim-lua/plenary.nvim", lazy = true },
    -- Blazingly fast file navigation
    {
        "ThePrimeagen/harpoon",
        keys = function()
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")
            return {
                { "<C-e>", mark.add_file, desc = "Add file to menu" },
                { "<C-m>", ui.toggle_quick_menu, desc = "Toggle menu" },
                {
                    "<C-t>",
                    function()
                        ui.nav_file(1)
                    end,
                    desc = "Go to 1st file",
                },
                {
                    "<C-g>",
                    function()
                        ui.nav_file(2)
                    end,
                    desc = "Go to 2nd file",
                },
                {
                    "<C-h>",
                    function()
                        ui.nav_file(3)
                    end,
                    desc = "Go to 3rd file",
                },
                {
                    "<C-y>",
                    function()
                        ui.nav_file(4)
                    end,
                    desc = "Go to 4th file",
                },
            }
        end,
    },
    -- Fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        keys = function()
            local builtin = require("telescope.builtin")
            return {
                { "<leader>ff", builtin.find_files, desc = "Find files by name" },
                { "<leader>fg", builtin.live_grep, desc = "Find files by content" },
                {
                    "<leader>fc",
                    builtin.command_history,
                    desc = "Find commands in history",
                },
                { "<leader>fh", builtin.help_tags, desc = "Find nvim help" },
                { "<leader>fk", builtin.keymaps, desc = "Find keymappings" },
            }
        end,
        dependencies = {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
        config = function()
            require("telescope").load_extension("fzf")
        end,
    },
    -- Icons
    { "nvim-tree/nvim-web-devicons", lazy = true },
    -- Status line
    { "nvim-lualine/lualine.nvim", event = "VeryLazy", opts = {} },
    -- Auto pairs
    { "windwp/nvim-autopairs", lazy = true, opts = {} },
    -- Almighty syntax, smart selection, context and
    -- new text objects (class, function, call, parameter)
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "TSUpdateSync" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            { "nvim-treesitter/nvim-treesitter-context", opts = {} },
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
                "json",
                "yaml",
                "query",
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
    -- Language Server Protocol support
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "williamboman/mason.nvim", opts = {} },
            {
                "williamboman/mason-lspconfig.nvim",
                opts = {
                    ensure_installed = {
                        "lua_ls",
                        "pyright",
                        "clangd",
                    },
                },
            },
            { "folke/neodev.nvim", opts = {} },
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local lsp = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            lsp.lua_ls.setup({
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
            })
            lsp.pyright.setup({ capabilities = capabilities })
            lsp.clangd.setup({ capabilities = capabilities })

            vim.keymap.set(
                "n",
                "<leader>M",
                vim.diagnostic.open_float,
                { desc = "Show more diagnostic info in a floating window" }
            )
            vim.keymap.set(
                "n",
                "<leader>ld",
                vim.diagnostic.setloclist,
                { desc = "Open diagnostics in location list" }
            )
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    vim.keymap.set(
                        "n",
                        "<leader>R",
                        vim.lsp.buf.rename,
                        { buffer = ev.buf, desc = "Rename all references to the word" }
                    )
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, {
                        buffer = ev.buf,
                        desc = "Display hover information about the word",
                    })
                    vim.keymap.set("n", "<leader>K", vim.lsp.buf.signature_help, {
                        buffer = ev.buf,
                        desc = "Display signature information about the word",
                    })
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {
                        buffer = ev.buf,
                        desc = "Jump to the declaration of the word",
                    })
                    vim.keymap.set(
                        "n",
                        "gd",
                        vim.lsp.buf.definition,
                        { buffer = ev.buf, desc = "Jump to the definition of the word" }
                    )
                    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, {
                        buffer = ev.buf,
                        desc = "Jump to the definition of the type of the word",
                    })
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {
                        buffer = ev.buf,
                        desc = "List implementations for the word in the quickfix window",
                    })
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, {
                        buffer = ev.buf,
                        desc = "List references to the word in the quickfix window",
                    })
                    vim.keymap.set(
                        "n",
                        "<leader>wa",
                        vim.lsp.buf.add_workspace_folder,
                        {
                            buffer = ev.buf,
                            desc = "Add the folder to the workspace folders",
                        }
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>wr",
                        vim.lsp.buf.remove_workspace_folder,
                        {
                            buffer = ev.buf,
                            desc = "Remove the folder from the workspace folders",
                        }
                    )
                    vim.keymap.set("n", "<leader>wl", function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, {
                        buffer = ev.buf,
                        desc = "Print workspace folders",
                    })
                end,
            })
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
                        behavior = cmp.SelectBehavior.Insert,
                    }),
                    ["<C-p>"] = cmp.mapping.select_prev_item({
                        behavior = cmp.SelectBehavior.Insert,
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
                        local icons = require("core.icons").kinds
                        item.kind = (icons[item.kind] or "") .. item.kind
                        return item
                    end,
                },
            }
        end,
        config = function(_, opts)
            local cmp = require("cmp")
            cmp.setup(opts)
            cmp.event:on(
                "confirm_done",
                require("nvim-autopairs.completion.cmp").on_confirm_done()
            )
        end,
    },
    -- Snippets
    {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        lazy = true,
        dependencies = {
            "rafamadriz/friendly-snippets",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end,
        },
        config = function()
            local ls = require("luasnip")
            vim.keymap.set({ "i" }, "<C-l>", function()
                ls.expand()
            end, { silent = true, desc = "Expand snippet" })
            vim.keymap.set({ "i", "s" }, "<C-j>", function()
                ls.jump(1)
            end, { silent = true, desc = "Jump forward snippet" })
            vim.keymap.set({ "i", "s" }, "<C-k>", function()
                ls.jump(-1)
            end, { silent = true, desc = "Jump backward snippet" })
        end,
    },
    -- Commenting
    {
        "numToStr/Comment.nvim",
        opts = {},
        keys = {
            { "gc", mode = { "n", "x" }, desc = "Line-comment toggle" },
            { "gb", mode = { "n", "x" }, desc = "Block-comment toggle" },
            { "gcc", desc = "Line-comment toggle line" },
            { "gbc", desc = "Block-comment toggle line" },
            { "gcO", desc = "Add comment on the line above" },
            { "gco", desc = "Add comment on the line below" },
            { "gcA", desc = "Add comment at the end of line" },
        },
    },
    -- Better comments
    {
        "folke/todo-comments.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {},
        config = function(_, opts)
            local todo = require("todo-comments")
            todo.setup(opts)
            vim.keymap.set(
                "n",
                "<leader>lt",
                "<cmd>TodoLocList<CR>",
                { desc = "Open todos in location list" }
            )
        end,
    },
    -- Lazygit integration
    {
        "kdheepak/lazygit.nvim",
        keys = {
            { "gl", "<cmd>LazyGit<CR>", desc = "Open lazygit" },
        },
    },
    -- Format runner
    {
        "mhartington/formatter.nvim",
        event = "BufWritePost",
        opts = function()
            return {
                logging = true,
                log_level = vim.log.levels.WARN,
                filetype = {
                    lua = { require("formatter.filetypes.lua").stylua },
                    python = { require("formatter.filetypes.python").black },
                },
            }
        end,
        config = function(_, opts)
            require("formatter").setup(opts)
            vim.api.nvim_create_autocmd("BufWritePost", {
                group = vim.api.nvim_create_augroup("FormatAutogroup", {}),
                command = "FormatWrite",
            })
        end,
    },
    -- Annotation generator
    {
        "danymat/neogen",
        keys = {
            { "ga", "<cmd>Neogen<CR>", desc = "Generate annotation" },
        },
        opts = {
            snippet_engine = "luasnip",
        },
    },
})
