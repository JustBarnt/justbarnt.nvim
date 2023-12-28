return {
    "jinh0/eyeliner.nvim",
    config = function()
        vim.api.nvim_set_hl(0, "EyelinerPrimary", { fg = "#d11987", bold = true, underline = true })
        vim.api.nvim_set_hl(0, "EyelinerSecondary", { fg = "#d11987", underline = true })

        vim.api.nvim_create_autocmd("colorscheme", {
            pattern = "*",
            callback = function()
                vim.api.nvim_set_hl(0, "EyelinerPrimary", { bold = true, underline = true })
            end,
        })

        require("eyeliner").setup({
            highlight_on_key = true,
            dim = true,
        })
    end,
}
