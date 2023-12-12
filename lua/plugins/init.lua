return {
    { "nvim-lua/plenary.nvim", dev = false },
    "milisims/nvim-luaref", -- Adds help refs to built-in lua functions
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        opts = {},
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
    {
        "justbarnt/dotenv.nvim",
    },
}
