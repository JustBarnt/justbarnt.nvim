return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        lazy = true,
        config = function()
            local wk = require("which-key")

            ---@type Options
            local opts = {
                plugins = {
                    marks = false, -- Shows a list of your marks on ' or `
                    registers = false, -- Shows your registers on " in NORMAL or <C-r> in INSERT
                },
                presets = {
                    operators = false,
                    motions = false,
                    text_objects = false,
                    windows = false,
                    nav = false,
                    z = false,
                    g = false,
                },
                motions = {
                    count = true,
                },
            }

            wk.setup(opts)
            --[[ wk.register(registers.defaults, {
                mode = "n", -- register none, normal mode keys using options "i,x,v"
                prefix = "<leader>",
            }) ]]

            -- TODO: Register non_leader keybinds
        end,
    }
}

