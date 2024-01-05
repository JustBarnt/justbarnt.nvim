return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("jb.lsp")
        end,
    },
    {
        "williamboman/mason.nvim",
        dependencies = {
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "onsails/lspkind-nvim",
            { "L3MON4D3/LuaSnip" },
        },
    },
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
