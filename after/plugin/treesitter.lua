if not pcall(require, "nvim-treesitter") then
    -- TODO Add vim.notify log using figdet.nvim or some other notifying api
    return
end

local list = require("nvim-treesitter.parsers").get_parser_configs()

list.lua = {
  install_info = {
    url = "https://github.com/tjdevries/tree-sitter-lua",
    revision = "0e860f697901c9b610104eb61d3812755d5211fc",
    files = { "src/parser.c", "src/scanner.c" },
    branch = "master",
  },
}

local _ = require("nvim-treesitter.configs").setup{
    ensure_installed = { 
        "html",
        "javascript",
        "json",
        "markdown",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
    },

    highlight = { enable = true },
    refactor = { 
        highlight_definitions = { enable = true },
        highlight_current_scope = { enable = false },
    
        smart_rename = { 
            enable = false,
            keymaps = {
                smart_rename = "grr",
            },
        },

        navigation = {
            enable = false,
            keymaps = {
                goto_definition = "gd",
                list_definitions = "gD",
            },
        },
    },
    
    context_commentstring = {
        enable = true,

        -- With Comment.nvim, we don't need to run this on the autocmd
        --  Only run it in pre-hook
        enable_autocmd = false,

    },

    textobjects = {
        move = {
            enable = true,
            set_jumps = true,

            goto_next_start = {
                ["]p"] = "@parameter.inner",
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[p"] = "@parameter.inner",
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        },

        select = {
            enable = true,
            lookahead = true,

            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",

                ["ac"] = "@conditional.outer",
                ["ic"] = "@conditional.inner",

                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",

                ["av"] = "@variable.outer",
                ["iv"] = "@variable.inner",
            },
        },

        swap = {
            enable = true,
            swap_next = swap_next,
            swap_previous = swap_prev,
        },
    },

    playground = {
        enable = true,
        updatetime = 25,
        persist_queries = true,
        keybindings = {
            toggle_query_editor = "o",
            toggle_hl_groups = "i",
            toggle_injected_languages = "t",

            -- This shows stuff like literal strings, commas, etc.
            toggle_anonymous_nodes = "a",
            toggle_language_display = "I",
            focus_language = "f",
            unfocus_language = "F",
            update = "R",
            goto_node = "<cr>",
            show_help = "?",
        },
    },
}

require("treesitter-context").setup { enable = true }

vim.treesitter.query.set("javascript", "context", "")
vim.treesitter.query.set("typescript", "context", "")
vim.treesitter.query.set("lua", "context", "")
