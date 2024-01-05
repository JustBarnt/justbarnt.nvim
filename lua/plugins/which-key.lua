return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    lazy = true,
    config = function()
        local wk = require("which-key")

        ---@type Options
        local opts = {}

        local registers = require("core.which-key.registers")
        wk.setup(opts)
        wk.register(registers.defaults, {
            mode = "n",
            prefix = "<leader>",
        })

        -- TODO: Register non_leader keybinds
    end,
    {
        "tris203/hawtkeys.nvim",
        event = "VeryLazy",
        lazy = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local hawtkeys = require("hawtkeys")

            ---@class HawtKeyPartialConfig
            local config = {
                leader = " ",
                homerow = 2,
                powerFingers = { 2, 3, 6, 7 },
                keyboardLayout = "qwerty",
                customMaps = {
                    ["wk.register"] = {
                        method = "which_key",
                    },
                    ["lazy"] = {
                        method = "lazy",
                    },
                },
            }

            hawtkeys.setup(config)
        end,
    },
}
