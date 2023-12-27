local noice = require("noice")

---@class NoiceConfig
local noice_config = {
    format = {
        telescope = require("telescope").load_extension("noice"),
        telescope_preview = require("telescope").load_extension("noice"),
    },
    lsp = {
        progress = {
            enabled = true,
            view = "notify",
        },
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        },
    },
    presets = {
        bottom_search = true,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
    },
    views = {
        cmdline_popup = {
            border = {
                style = "none",
                padding = { 2, 2 },
            },
            filter_options = {},
            win_options = {
                winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
            },
        },
        notify = {
            replace = true,
        },
    },
}

noice.setup(noice_config)
