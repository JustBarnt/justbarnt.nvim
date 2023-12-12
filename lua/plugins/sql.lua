return {
    "tpope/vim-dadbod",
    "kristijanhusak/vim-dadbod-completion",
    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = {
            { "tpope/vim-dadbod", lazy = true },
            {
                "kristijanhusak/vim-dadbod-completion",
                ft = {
                    "sql", --[Dont need these file types yet: [ 'mysql', 'plsql' ]]
                },
                lazy = true,
            },
        },
        cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
        init = function()
            vim.g.db_ui_use_nerd_fonts = 1
        end,
    },
}
