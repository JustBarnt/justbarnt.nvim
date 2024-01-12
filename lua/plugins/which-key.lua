return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        lazy = true,
        config = function()
            local wk = require("which-key")
            vim.opt.timeout = true 
            vim.opt.timeoutlen = 300

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

