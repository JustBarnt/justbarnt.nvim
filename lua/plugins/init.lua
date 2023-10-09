-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
    --------------------------------
    ----- Coding Configuration -----
    --------------------------------
    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup({
                icons = false,
            })
        end
    },

    {
        "nvim-treesitter/nvim-treesitter",
        run = function()
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true})
        end,
        dependencies = {
            "nvim-treesitter/playground",
            "nvim-treesitter/nvim-treesitter-context"
        }
        -- config = function()
        --     require("plugins.config.treesitter")
        -- end,
        -- build = ":TSUpdate",
    }, -- Handles syntax parsing for files.}

    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        config = function()
            require("plugins.config.lsp")
        end,
        dependencies = {
            -- LSP Support
            "neovim/nvim-lspconfig",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",

            -- Autocompletion
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            
            -- Snippets
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets"
        }
    },

    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        config = function()
            require("plugins.config.telescope")
        end,
        dependencies = { 
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build" },
            "nvim-tree/nvim-web-devicons"
        }, 
    }, --fuzzy finding

    {
        "tpope/vim-fugative"
    },

    --------------------------------
    --- End Coding Configuration ---
    --------------------------------
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000, -- Load before any other plugins
    }, -- preferred colorscheme

    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("plugins.config.lualine")
        end,
        dependencies = { "nvim-tree/nvim-web-devicons"}
    }, -- Statusline

    -- Git integration
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

    {
        "folke/which-key.nvim",
        config = function()
            require("plugins.config.whichkeys")    
        end,
        opts = {}
    },
    --[[
    {
        "folke/noice.nvim",
        config = function()
            require("plugins.config.noice")
        end,
        dependencies = {
            "MunifTanjim/nui.nvim"
        }
    } --]]  
}
