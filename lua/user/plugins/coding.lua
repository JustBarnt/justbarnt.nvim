return {
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
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            {"hrsh7th/cmp-nvim-lsp"},
            {"pmizio/typescript-tools.nvim"}
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
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = function()
                    local os_name = vim.loop.os_uname().sysname;

                    if os_name == "Windows_NT" then
                        return "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
                    elseif os_name == "Darwin" then
                        return "make"
                    end
                end,
            },
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
    }
}
