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
            require("plugins.config.treesitter")
        end,
        build = ":TSUpdate",
    }, -- Handles syntax parsing for files

    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        lazy = true,
        config = function()
            local lsp_zero = require('lsp-zero')

            lsp_zero.on_attach(function(client, bufnr)
                lsp_zero.default_keymaps({buffer = bufnr})
            end)

            require('lspconfig').powershell_es.setup({
                bundle_path = "C:\\PowerShellEditor\\PowerShellEditorServices"
            })
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
            lsp_zero.setup_servers({'cmake', 'emmet_language_server', 'eslint', 'html', 'intelephense', 'jsonls', 'lua_ls', 'svelte', 'tailwindcss', 'tsserver', })
        end,
    },

    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {'hrsh7th/cmp-nvim-lsp'},
        }
    },

    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            {'L3MON4D3/LuaSnip'}  
        },
    },

    -- Fuzzy Finder
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
    
    -- Git Integration
    --{
      --  "tpope/vim-fugative"
    --},

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
