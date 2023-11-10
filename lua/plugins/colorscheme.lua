if not vim.g.vscode then
    return {
        {
            "ellisonleao/gruvbox.nvim",
            priority = 1000, -- Load before any other plugins
        }, -- preferred colorscheme
        {
            "folke/tokyonight.nvim",
            lazy = false,
            priority =  1000,
        }
    }
end
