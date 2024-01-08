return {
    {
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
    }
}

