return {
    {
        "folke/which-key.nvim",
        config = function()
            require("jb.whichkey")
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },
    {
        "jinh0/eyeliner.nvim",
        config = function()
            -- Uncomment if you want to make Eyliner more subtle and only be bold and underlined
            vim.api.nvim_set_hl(0, "EyelinerPrimary", { fg = "#d11987", bold = true, underline = true })
            vim.api.nvim_set_hl(0, "EyelinerSecondary", { fg = "#d11987", underline = true })

            -- autocmd to updated Eyeliners colors if you change your colorscheme
            vim.api.nvim_create_autocmd("colorscheme", {
                pattern = "*",
                callback = function()
                    vim.api.nvim_set_hl(0, "EyelinerPrimary", { bold = true, underline = true })
                end,
            })

            return require("eyeliner").setup({
                highlight_on_key = true,
                dim = true,
            })
        end,
    },
    "junegunn/vim-easy-align",
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "mg979/vim-visual-multi",
        branch = "master",
    },
}
