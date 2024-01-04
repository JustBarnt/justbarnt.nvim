return {
    {
        "hrsh7th/nvim-cmp",
        config = function()
            require("plugins.cmp.completion")
        end,
        dependencies = {
            "onsails/lspkind-nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lua",
        },
    },
    { "saadparwaiz1/cmp_luasnip", dependencies = { "L3MON4D3/LuaSnip" } },
}
