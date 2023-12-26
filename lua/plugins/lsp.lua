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
    "folke/trouble.nvim",
    {
        "folke/noice.nvim",
        config = function()
            require("noice").setup({
                format = {
                    telescope = require("telescope").load_extension("noice"),
                    telescope_preview = require("telescope").load_extension("noice"),
                },
                lsp = {
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                },
                presets = {
                    bottom_search = true,
                    long_message_to_split = true,
                    inc_rename = true,
                    lsp_doc_border = true,
                },
            })
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
    },
}
