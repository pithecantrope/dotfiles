return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        -- Package manager
        {
            "williamboman/mason.nvim",
            opts = {
                ui = {
                    border = "rounded",
                    width = 0.5,
                },
            },
        },
        {
            "williamboman/mason-lspconfig.nvim",
            opts = {
                ensure_installed = {
                    "lua_ls",
                    "pyright",
                    "clangd",
                    "gopls",
                },
            },
        },
        -- Lua lsp setup
        { "folke/neodev.nvim", opts = {} },
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
        lsp.gopls.setup({
            capabilities = capabilities,
            settings = {
                gopls = {
                    usePlaceholders = true,
                },
            },
        })

        vim.keymap.set("n", "<leader>M", vim.diagnostic.open_float, { desc = "Show diagnostic info" })
        vim.keymap.set("n", "<leader>ld", vim.diagnostic.setloclist, { desc = "List diagnostics" })
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation, {
                    buffer = ev.buf,
                    desc = "List implementations for the word",
                })
                vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, {
                    buffer = ev.buf,
                    desc = "List references to the word",
                })
                vim.keymap.set("n", "<leader>R", vim.lsp.buf.rename, {
                    buffer = ev.buf,
                    desc = "Rename references to the word",
                })
                vim.keymap.set("n", "<leader>C", vim.lsp.buf.code_action, {
                    buffer = ev.buf,
                    desc = "Pick a code action",
                })
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
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
                    buffer = ev.buf,
                    desc = "Jump to the definition of the word",
                })
                vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, {
                    buffer = ev.buf,
                    desc = "Jump to the definition of the type of the word",
                })
            end,
        })

        vim.fn.sign_define("DiagnosticSignError", {
            text = "",
            texthl = "DiagnosticSignError",
            numhl = "DiagnosticSignError",
        })
        vim.fn.sign_define("DiagnosticSignWarn", {
            text = "",
            texthl = "DiagnosticSignWarn",
            numhl = "DiagnosticSignWarn",
        })
        vim.fn.sign_define("DiagnosticSignHint", {
            text = "",
            texthl = "DiagnosticSignHint",
            numhl = "DiagnosticSignHint",
        })
        vim.fn.sign_define("DiagnosticSignInfo", {
            text = "",
            texthl = "DiagnosticSignInfo",
            numhl = "DiagnosticSignInfo",
        })
    end,
}
