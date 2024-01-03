return {
    {
        "nvim-lua/plenary.nvim",
        dev = false,
    },
    "milisims/nvim-luaref", -- Adds help refs to built-in lua functions
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            local surround = require("nvim-surround")
            local input = require("nvim-surround.input")
            local functional = require("nvim-surround.functional")

            ---@class user_options
            local opts = {}

            surround.setup(opts)
        end,
    },
    "godlygeek/tabular", -- Quickly align text by pattern
    {
        "luukvbaal/statuscol.nvim",
        config = function()
            require("statuscol").setup({
                setopt = true,
            })
        end,
    },
}
