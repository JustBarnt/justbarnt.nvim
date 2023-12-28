return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    lazy = true,
    config = function()
        local wk = require("which-key")

        ---@type Options
        local opts = {
            plugins = {
                marks = false,
                registers = false,
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
            window = {
                border = "single",
                position = "bottom",
                margin = { 2, 0, 2, 0 },
                padding = { 2 },
                winblend = 0,
                zindex = 1000,
            },
            ignore_missing = true,
            hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
            show_help = true,
            show_keys = true,
            triggers = "auto",
            triggers_blacklist = {
                i = { "j", "k" },
                v = { "j", "k" },
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
