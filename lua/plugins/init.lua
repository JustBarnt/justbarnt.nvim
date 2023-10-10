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
        config = false,
        init = function()
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = true
    }, 

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            {
                'L3MON4D3/LuaSnip',
                "rafamadriz/friendly-snippets",
                "hrsh7th/nvim-cmp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "saadparwaiz1/cmp_luasnip",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-nvim-lua",
            },
        },
        config = function()
            -- TODO: Move into after/plugings/autocomplete
            -- Here is where you configure the autocompletion settings.
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_cmp()

            -- And you can configure cmp even more, if you want to.
            local cmp = require('cmp')
            local cmp_action = lsp_zero.cmp_action()

            cmp.setup({
                formatting = lsp_zero.cmp_format(),
                mapping = cmp.mapping.preset.insert({
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
                    ['<C-e>'] = cmp.mapping.abort(),
                })
            })
        end
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = {'LspInfo', 'LspInstall', 'LspStart'},
        event = {'BufReadPre', 'BufNewFile'},
        dependencies = {
            {'hrsh7th/cmp-nvim-lsp'},
            {'williamboman/mason-lspconfig.nvim'},
            {"hrsh7th/nvim-cmp"},
            {"hrsh7th/cmp-buffer"},
            {"hrsh7th/cmp-path"},
        },
        config = function()
            -- TODO: Move to after/plugins/lsp
            -- This is where all the LSP shenanigans will live
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_lspconfig()

            lsp_zero.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                lsp_zero.default_keymaps({buffer = bufnr})
            end)

            require('mason-lspconfig').setup({
                ensure_installed = {},
                handlers = {
                    lsp_zero.default_setup,
                    lua_ls = function()
                        -- (Optional) Configure lua language server for neovim
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        require('lspconfig').lua_ls.setup(lua_opts)
                    end,
                }
            })
        end
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
