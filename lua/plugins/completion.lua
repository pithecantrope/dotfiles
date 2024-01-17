return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-path",
        -- Pictograms
        "onsails/lspkind.nvim",
    },
    opts = function()
        local cmp = require("cmp")

        return {
            snippet = {
                expand = function(args) require("luasnip").lsp_expand(args.body) end,
            },
            window = {
                completion = {
                    border = "rounded",
                    winhighlight = "NormalFloat:FloatBorder,CursorLine:Visual,Search:None",
                    col_offset = -3,
                    side_padding = 1,
                    scrollbar = false,
                },
                documentation = {
                    border = "rounded",
                    scrollbar = false,
                    winhighlight = "NormalFloat:FloatBorder,CursorLine:Visual,Search:None",
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
                fields = { "kind", "abbr", "menu" },
                format = require("lspkind").cmp_format({
                    mode = "symbol",
                    maxwidth = 40,
                    ellipsis_char = "...",
                    symbol_map = {
                        Codeium = "",
                        Module = "",
                        Operator = "",
                        Property = "",
                        TypeParameter = "T",
                    },
                }),
            },
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "path" },
            }),
        }
    end,
}
