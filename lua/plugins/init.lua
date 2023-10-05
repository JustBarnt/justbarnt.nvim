-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000, -- Load before any other plugins
    }, -- preferred colorscheme

    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup()
        end
    }, -- Delete and change surroundings

    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("plugins.config.lualine")
        end,
        dependencies = { "nvim-tree/nvim-web-devicons"}
    }, -- Statusline

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
        "neovim/nvim-lspconfig",
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            { 
                "williamboman/mason.nvim", 
                config = function() 
                    require("plugins.config.lsp.mason") 
                end 
            },
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",

            -- Status updates for LSP
            { "j-hui/fidget.nvim", tag = "legacy", opts = {} },

            -- Additional lua configuration, makes nvim stuff cool
            "folke/neodev.nvim"
        }
    },

    {
        -- Autocompletion
        "hrsh7th/nvim-cmp",
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",

            -- Adds LSP completion capabilities
            "hrsh7th/cmp-buffer", -- source for text in buffer
            "hrsh7th/cmp-path", -- source for file system paths
            "hrsh7th/cmp-nvim-lsp", -- autocompletion
            "hrsh7th/cmp-nvim-lsp-signature-help", -- function param hints
            "onsails/lspkind.nvim", -- vs-code like icons for autocompletion

            -- Adds a number of user-friendly snippets
            "rafamadriz/friendly-snippets",
        },
    },

    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("plugins.config.treesitter")
        end,
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring", -- allow comments in mixed content files like svelte
            "windwp/nvim-ts-autotag", -- autoclose html tags
        },
        build = ":TSUpdate",
    }, -- Handles syntax parsing for files.

    -- Enhanced LSP UIs
    {
        "glepnir/lspsaga.nvim",
        event = "LspAttach",
        config = function()
            require("plugins.config.lsp.lspsaga")
        end,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "nvim-treesitter/nvim-treesitter",
        },
    },

    -- Commenting
    -- gc to comment visual regions/lines
    {
        "terrortylor/nvim-comment",
        config = function()
            require("plugins.config.comments")
        end,
    },

    -- Auto Closing
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("plugins.config.autopairs")
        end,
    },

    -- Git integration
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("plugins.config.gitsigns")
        end,
    },

    -- Diff files
    {
        "sindrets/diffview.nvim",
        config = function()
            require("plugins.config.diffview")
        end,
        dependencies = {
            "nvim-lua/plenary.nvim"
        }
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
        event = "VeryLazy",
        opts = {
            -- your configuration here
            -- or leave it empty to use default settings
        }
    }
}
