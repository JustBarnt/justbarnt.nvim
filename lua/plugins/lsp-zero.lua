-- return {}

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/nvim-cmp",
        },
    },
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-cmdline" },

            -- Snippets
            { "L3MON4D3/LuaSnip" },
        },
        config = function()
            require("core.lsp-zero")
        end,
    },
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
    "jose-elias-alvarez/nvim-lsp-ts-utils", -- TODO: repace with typescript.nvim
    "b0o/schemastore.nvim",
    {
        "stevearc/conform.nvim",
    },
}
