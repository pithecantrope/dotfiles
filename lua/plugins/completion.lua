return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-path",
        "onsails/lspkind.nvim",
    },
    opts = function()
        local cmp = require("cmp")

        return {
            snippet = {
                expand = function(args) vim.snippet.expand(args.body) end,
            },
            window = {
                completion = {
                    border = "rounded",
                    winhighlight = "NormalFloat:FloatBorder,CursorLine:Visual,Search:None",
                    scrollbar = false,
                },
                documentation = {
                    border = "rounded",
                    winhighlight = "NormalFloat:FloatBorder,CursorLine:Visual,Search:None",
                    scrollbar = false,
                },
            },
            completion = {
                completeopt = "menu,menuone,noinsert",
            },
            mapping = {
                ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-u>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
            },
            formatting = {
                format = require("lspkind").cmp_format(),
            },
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "path" },
            }),
        }
    end,
}
