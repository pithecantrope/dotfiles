return {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "black" },
            c = { "clangformat" },
            cpp = { "clangformat" },
        },
        format_on_save = {
            timeout_ms = 500,
            lsp_fallback = true,
        },
        notify_on_error = false,
    },
}
