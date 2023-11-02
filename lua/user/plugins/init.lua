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
    -- Accurate Code Syntax Highlighing
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/playground",
            "nvim-treesitter/nvim-treesitter-context"
        },
        config = function()
            require("user.plugins.config.treesitter")
        end,
        build = ":TSUpdate",
    }, -- Handles syntax parsing for files

    -- Start of LSP Related plugins
    {"williamboman/mason.nvim"},
    {"williamboman/mason-lspconfig.nvim"},
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {"hrsh7th/cmp-nvim-lsp"},
        }
    },
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        config = function()
            require("user.plugins.config.lspzero")
        end,
    },

    -- Start of Autocomplete plugins
    {
        "hrsh7th/nvim-cmp",
        config = function()
            require("user.plugins.config.nvim-cmp")
        end,
        dependencies = {
            {"L3MON4D3/LuaSnip"}
        },
    },
    { "hrsh7th/cmp-buffer"},

    -- Fuzzy Finder
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        config = function()
            require("user.plugins.config.telescope")
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build" },
            "nvim-tree/nvim-web-devicons",
        },
    },
    -- Autopairs for brakets, quotes, etc.
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {}
    },
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        opts = {
        }
    },
    {
        "smjonas/inc-rename.nvim",
        cmd = "IncRename",
        config = true,
    },
    --[[Plugins to play around with
    {
        "Wansmer/treesj",
        keys = {
            { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
        },
        opts = { use_default_keymaps = false, max_join_length = 150 },
    },

    {
        "cshuaimin/ssr.nvim",
        keys = {
            {
                "<leader>sR",
                function()
                    require("ssr").open()
                end,
                mode = { "n", "x" },
                desc = "Structural Replace",
            },
        },
    },
    --]]
    {
        "zbirenbaum/copilot.lua",
        opts = {
            filetypes = { ["*"] = true },
        }
    },
    --------------------------------
    --- End Coding Configuration ---
    --------------------------------
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000, -- Load before any other plugins
    }, -- preferred colorscheme
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority =  1000,
    },
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("user.plugins.config.lualine")
        end,
        dependencies = { "nvim-tree/nvim-web-devicons"}
    }, -- Statusline

    -- Git Signs for changes, deletes, etc.
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("user.plugins.config.gitsigns")
        end,
    },

    -- Harpoon (Quick file switching)
    {
        "ThePrimeagen/harpoon",
        config = function()
            require("user.plugins.config.harpoon")
        end,
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
    },

    -- Give visible guide to keybinds paired with Mapleader
    {
        "folke/which-key.nvim",
        config = function()
            require("user.plugins.config.whichkeys")
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
    -- Prettier Command Line
    {
        "folke/noice.nvim",
        event = 'VeryLazy',
        config = function()
            require("user.plugins.config.noice")
        end,
        dependencies = {
            "MunifTanjim/nui.nvim"
        }
    },
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration goes here, or leave empty for the default settings.
            })
        end,
    },
    "jidn/vim-dbml",
    {
        "jinh0/eyeliner.nvim",
        config = function()
            require("user.plugins.config.eyeliner")
        end,
    },
    {
        "trmckay/based.nvim",
        config = function()
            require("user.plugins.config.based")
        end,
    },
    "junegunn/vim-easy-align",
    -- install without yarn or npm
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },

    -- Discord Rich Presence
    {
        "andweeb/presence.nvim",
        config = function()
            require('user.plugins.config.discord')
        end,
    }
}
