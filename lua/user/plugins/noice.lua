if not vim.g.vscode then
    return {
        -- Prettier Command Line
        {
            "folke/noice.nvim",
            event = 'VeryLazy',
            config = function()
                require("user.plugins.config.noice")
            end,
            dependencies = {
                "MunifTanjim/nui.nvim"
            }
        },

    }
end
