return {
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            --require("plugins.config.lualine")
        end,
        dependencies = { "nvim-tree/nvim-web-devicons"}
    }, -- Statusline

    -- Git Signs for changes, deletes, etc.
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("plugins.config.gitsigns")
        end,
    },

    -- Harpoon (Quick file switching)
    {
        "ThePrimeagen/harpoon",
        config = function()
            require("plugins.config.harpoon")
        end,
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
    },

    -- Give visible guide to keybinds paired with Mapleader
    {
        "folke/which-key.nvim",
        config = function()
            require("plugins.config.whichkeys")
        end,
        opts = {}
    },
    {
        "2kabhishek/nerdy.nvim",
        cmd = "Nerdy",
        keys = {
            { "<leader>ci", "<cmd>Nerdy<CR>", desc = "Pick Icon"},
        }
    },
}
