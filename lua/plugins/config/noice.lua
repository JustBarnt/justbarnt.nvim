local status, noice = pcall(require, "noice")

if not status then
    return
end

noice.setup({
    cmdline = {
        format = {
            cmdline = {pattern = "^:", icon = "⪢", lang = "vim"},
            search_down = { view = "cmdline", icon = "🔎" },
            search_up = { view = "cmdline", icon = "🔍" },
            filter = { view = "cmdline" },
            help = {icon = "?"}
        }
    },
    format = {
        --telescope = require('telescope').load_extension('noice'),
        --telescope_preview = require('telescope').load_extension('noice')
    },
    lsp = {
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        }
    },
    presets = {
        bottom_search = false,
        command_palette = false,
        long_message_to_split = false,
        inc_rename = false,
        lsp_doc_border = false,
    },
})
