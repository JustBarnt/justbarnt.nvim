---@diagnostic disable: missing-fields
require("tokyonight").setup({
    style = "moon",
    light_style = "day",
    transparent = true,
    terminal_colors = true,
    styles = {
        comments = { italic = true },
        keywords = { bold = true },
        functions = {},
        variables = {},
        sidebars = "transparent",
        floats = "transparent",
    },
    sidebars = {
        "qf",
        "vista_kind",
        "terminal",
        "spectre_panel",
        "startuptime",
        "Outline",
    },
})

require("rose-pine").setup({
    variant = "main",
    dark_variant = "main",
    bold_vert_split = true,
    disable_background = true,
    highlight_groups = {
        ColorColumn = { bg = "pine", blend = 15 },
        CursorLine = { bg = "iris", blend = 10 },
        StatusLine = { fg = "iris", bg = "pine", blend = 10 },
        Search = { bg = "gold", inherit = false },
        FloatBorder = { bg = "#1A1C33", blend = 50 },
    },
})

vim.cmd.colorscheme("rose-pine")
