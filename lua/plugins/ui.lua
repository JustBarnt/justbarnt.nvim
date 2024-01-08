return {
    {
        "rcarriga/nvim-notify",
        config = function()
            local notify = require("notify")

            ---@class notify.Config
            local config = {
                fps = 20,
                timeout = 1500,
                background_colour = "#000000",
                stages = "static",
                render = "compact",
                max_height = function()
                    return math.floor(vim.o.lines * 0.5)
                end,
                max_width = function()
                    return math.floor(vim.o.columns * 0.45)
                end,
                on_open = function(win)
                    local buf = vim.api.nvim_win_get_buf(win)
                    vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
                    vim.api.nvim_win_set_config(win, { focusable = false })
                end,
            }

            notify.setup(config)
        end,
    },
    {
        "folke/trouble.nvim",
        config = function()
            local trouble = require("trouble")

            --[[ 
                # TODO
                    - [ ] Create function to toggle between diagnostic modes (At least workspace, quickfix, and lsp_references)
             ]]

            local mode = {
                "workspace_diagnostics",
                "document_diagnostics",
                "quickfix",
                "lsp_references",
                "loclist",
            }

            -- Defining class definition purely to give me intellesense on all setup options.
            ---@class TroubleOptions
            local trouble_options = {
                mode = mode[1], -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
                severity = nil, -- nil (ALL) or vim.diagnostic.severity.ERROR | WARN | INFO | HINT
                fold_open = "", -- icon used for open folds
                fold_closed = "", -- icon used for closed folds
                cycle_results = true, -- cycle item list when reaching beginning or end of list
                action_keys = { -- key mappings for actions in the trouble list
                    close = "q", -- close the list
                    cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
                    refresh = "r", -- manually refresh
                    jump = { "<cr>", "<tab>", "<2-leftmouse>" }, -- jump to the diagnostic or open / close folds
                    open_split = { "<c-s>" }, -- open buffer in new split
                    open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
                    open_tab = { "<c-t>" }, -- open buffer in new tab
                    jump_close = { "o" }, -- jump to the diagnostic and close the list
                    toggle_mode = "m", -- toggle between "workspace" and "document" mode
                    switch_severity = "S", -- switch "diagnostics" severity filter level to ALL / HINT / INFO / WARN / ERROR
                    toggle_preview = "P", -- toggle auto_preview
                    hover = "K", -- opens a small popup with the full multiline message
                    preview = "p", -- preview the diagnostic location
                    open_code_href = "c", -- if present, open a URI with more information about the diagnostic error
                    close_folds = { "zM", "zm" }, -- close all folds
                    open_folds = { "zR", "zr" }, -- open all folds
                    toggle_fold = { "zA", "za" }, -- toggle fold of current file
                    previous = "k", -- preview item
                    next = "j", -- next item
                    help = "?", -- help menu
                },
                multiline = true, -- render multi-line messages
                indent_lines = true, -- add an indent guide below the fold icons
                win_config = { border = "double" }, -- window configuration for floating windows. See |nvim_open_win()|.
                auto_open = false, -- automatically open the list when you have diagnostics
                auto_close = false, -- automatically close the list when you have no diagnostics
                auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
                auto_fold = false, -- automatically fold a file trouble list at creation
                auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
                signs = {
                    -- icons / text used for a diagnostic
                    error = "",
                    warning = "",
                    hint = "",
                    information = "",
                    other = "",
                },
                use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
                sort_keys = {
                    "severity",
                    "filename",
                    "lnum",
                    "col",
                },
            }

            trouble.setup(trouble_options)

            local remap = function(lhs, rhs, options, leader)
                local useLeader = leader or true

                if options.desc then
                    options.desc = "Trouble: " .. options.desc
                end

                -- I'm to lazy to type "<leader>" a million times.
                if useLeader then
                    lhs = "<leader>" .. lhs
                end

                vim.keymap.set("n", lhs, rhs, options)
            end

            remap("tt", function()
                require("trouble").toggle()
            end, { desc = "[T]oggle [T]rouble", silent = true })

            remap("tw", function()
                require("trouble").toggle(mode[1])
            end, { desc = "[T]oggle [W]orkspace Diagnostics", silent = true })

            remap("td", function()
                require("trouble").toggle(mode[2])
            end, { desc = "[T]oggle [D]ocument Diagnostics", silent = true })

            remap("tq", function()
                require("trouble").toggle(mode[3])
            end, { desc = "[T]oggle [Q]uick Fix", silent = true })

            remap("tl", function()
                require("trouble").toggle(mode[5])
            end, { desc = "[T]oggle [L]ocal List", silent = true })

            remap("tx", function()
                trouble.close()
            end, { desc = "[T]rouble Close", silent = true })

            remap("gR", function()
                require("trouble").toggle(mode[4])
            end, { desc = "[T]oggle LSP References", silent = true }, false)
        end,
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        config = function()
            local noice = require("noice")

            ---@class NoiceConfig
            local noice_config = {
                popupmenu = {
                    enabled = false,
                },
                messages = {
                    enabled = true,
                    view = "notify",
                    view_error = "notify",
                    view_warn = "mini",
                },
                routes = {
                    {
                        view = "mini",
                        filter = {
                            event = { "msg_show", "msg_showmode" },
                            ["not"] = {
                                kind = { "confirm", "confirm_sub" },
                            },
                        },
                    },
                    {
                        filter = {
                            event = "cmdline",
                            find = "^%s*[/?]",
                        },
                        view = "cmdline",
                    },
                },
                lsp = {
                    progress = {
                        enabled = true,
                    },
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                },
                presets = {
                    command_palette = true,
                    bottom_search = true,
                    long_message_to_split = true,
                    inc_rename = false,
                    lsp_doc_border = false,
                },
                views = {
                    cmdline_popup = {
                        position = "50%",
                        size = {
                            width = 60,
                            height = "auto",
                        },
                        border = {
                            style = "none",
                            padding = { 1, 1 },
                        },
                        filter_options = {},
                        win_options = {
                            winblend = 0,
                            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
                        },
                    },
                    notify = {
                        replace = true,
                    },
                },
            }

            noice.setup(noice_config)
        end,
    },
    {
        "m-demare/hlargs.nvim",
        config = function()
            require('hlargs').setup()
        end,
    }
}
