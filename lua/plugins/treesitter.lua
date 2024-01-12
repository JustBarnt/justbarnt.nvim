return {

    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            if not pcall(require, "nvim-treesitter") then
                return
            end

            -- Just contains the list of all current parsers
            local list = require("nvim-treesitter.parsers").get_parser_configs()

            local swap_next, swap_prev = (function()
                local swap_objects = {
                    p = "@parameter.inner",
                    f = "@function.outer",
                    e = "@element",
                }

                local n, p = {}, {}

                for key, obj in pairs(swap_objects) do
                    n[string.format("<M-Space><M-%s>", key)] = obj
                    p[string.format("<M-BS><M-%s>", key)] = obj
                end

                return n, p
            end)()

            ---@diagnostic disable: missing-fields
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "bash",
                    "html",
                    "javascript",
                    "json",
                    "markdown",
                    "markdown_inline",
                    "toml",
                    "tsx",
                    "typescript",
                    "vim",
                    "lua",
                    "regex",
                    "svelte",
                    "c_sharp",
                    "cmake",
                    "c",
                    "cpp",
                    "vimdoc",
                    "php",
                    "xml",
                },
                indent = {
                    enable = true,
                },
                highlight = {
                    enable = true,
                    disable = function() -- Disable in large buffers
                        local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
                        local line_count = vim.api.nvim_buf_line_count(0)

                        if filetype == 'xml' and line_count > 1000 then
                            return true
                        elseif line_count > 5000 then
                            return true
                        else 
                            return false
                        end
                    end,
                },
                refactor = {
                    highlight_definitions = { enable = true },
                    highlight_current_scope = { enable = false },

                    smart_rename = {
                        enable = true,
                        keymaps = {
                            smart_rename = "<leader>cR",
                        },
                    },

                    navigation = {
                        enable = false,
                    },
                },

                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<M-w>",
                        node_incremental = "<M-w>",
                        node_decremental = "<M-C-w>",
                        scope_incremental = "<M-e>",
                    },
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
            })

            require("ts_context_commentstring").setup({
                -- With Comment.nvim, we don't need to run this on the autocmd
                --  Only run it in pre-hook
                enable_autocmd = false,
            })

            require("treesitter-context").setup({ enable = true })

            vim.treesitter.query.set("javascript", "context", "")
            vim.treesitter.query.set("typescript", "context", "")
            vim.treesitter.query.set("lua", "context", "")
            vim.treesitter.query.set("xml", "context", "")
        end,
    },
    "nvim-treesitter/nvim-treesitter-refactor",
    "nvim-treesitter/playground",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "JoosepAlviste/nvim-ts-context-commentstring",
    "nvim-treesitter/nvim-treesitter-context",
}
