local status, confirm = pcall(require, "conform")
if not status then
    print("conform did not load")
    return
end

conform.setup({
    formatters_by_ft = {
        -- lua
        lua = { "stylua" },
        -- web based
        javascript = { { "prettierd", "prettier" } },
        typescript = { { "prettierd", "prettier" } },
        html = { { "prettierd", "prettier" } },
        css = { { "prettierd", "prettier" } },

        -- svelte
        svelte = { { "prettierd", "prettier" } },

        -- everything else will use LSP format
    },
    format_on_save = {
        timeout_ms = 4000,
        lsp_fallback = true
    }
})
