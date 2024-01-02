return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("jb.lsp")
        end,
    },
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",

    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        config = function()
            require("mason-tool-installer").setup({
                auto_update = true,
                debounce_hours = 24,
                ensure_installed = {
                    "stylua",
                    "lua-language-server",
                },
            })
        end,
    },
    "simrat39/inlay-hints.nvim",
    "folke/neodev.nvim",
    "jose-elias-alvarez/nvim-lsp-ts-utils", -- TODO: repace with typescript.nvim
    "b0o/schemastore.nvim",
    {
        "stevearc/conform.nvim",
        keys = {
            {
                "<leader>f",
                function()
                    require("conform").format({ async = true, lsp_fallback = true })
                end,
                mode = "",
                desc = "[F]ormat Buffer",
            },
        },
    },
}
