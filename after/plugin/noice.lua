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
