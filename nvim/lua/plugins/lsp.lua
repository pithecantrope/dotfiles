return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = "hrsh7th/cmp-nvim-lsp",
        config = function()
            local lsp = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            lsp.lua_ls.setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        workspace = { checkThirdParty = false },
                        completion = { callSnippet = "Replace" },
                    },
                },
            })
            lsp.clangd.setup({ capabilities = capabilities })

            vim.keymap.set("n", "<leader>m", vim.diagnostic.open_float)
            -- vim.keymap.set("n", "<leader>m", vim.diagnostic.open_float)
            -- vim.api.nvim_create_autocmd("LspAttach", {
            --     group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            --     callback = function(ev)
            --         vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation, { buffer = ev.buf })
            --         vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, { buffer = ev.buf })
            --         vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = ev.buf })
            --         vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf })
            --         vim.keymap.set("n", "<leader>K", vim.lsp.buf.signature_help, { buffer = ev.buf })
            --         vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf })
            --         vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, { buffer = ev.buf })
            --         vim.keymap.set("n", "<leader>D", vim.lsp.buf.declaration, { buffer = ev.buf })
            --     end,
            -- })
        end,
    },
    { "folke/lazydev.nvim", ft = "lua", opts = {} },
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                c = { "clangformat" },
            },
            format_on_save = { timeout_ms = 500, lsp_fallback = true },
            notify_on_error = false,
        },
    },
}
