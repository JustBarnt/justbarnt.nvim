-- color palette taken from gruvbox material medium intensity:
-- https://user-images.githubusercontent.com/58662350/213884019-cbcd5f00-5bef-4a37-9139-0570770330b6.png
local customColors = {
	bright_red = "#ea6962",
	bright_orange = "#e78a4e",
	bright_yellow = "#d8a657",
	bright_green = "#a9b665",
	bright_aqua = "#89b482",
	bright_purple = "#d3869b",
	bright_blue = "#7daea3",
}

local customHighlights = {
	-- Telescope
	TelescopeResultsDiffChange = { fg = customColors.bright_yellow, bg = "NONE" },
	TelescopeResultsDiffAdd = { fg = customColors.bright_green, bg = "NONE" },
	TelescopeResultsDiffDelete = { fg = customColors.bright_red, bg = "NONE" },
	TelescopeResultsDiffUntracked = { bg = "NONE" },
}

require("gruvbox").setup({
    transparent_mode = true,
    undercurl = false,
    underline = false,
    bold = false,
    italic = {
        strings = false,
        comments = false,
        operators = false,
        folds = false
    },
    invert_selection = false,
    strikethrough = false,
    palette_overrides = customColors,
    overrides = customHighlights,
})

require("tokyonight").setup({
    style = 'night',
    light_style = 'day',
    transparent = false,
    terminal_colors = true,
    styles = {
        comments = { italic = true },
        keywords = { bold = true },
        functions = {},
        variables = {},
        sidebars = 'dark',
        floats = 'dark',
    },
    sidebars = {'qf', "help"},
    day_brightness = 0.3,
    hide_inactive_statusline = false,
    dim_inactive = false,
    lualine_bold = false,
    on_colors = function(colors) end,
    on_highlights = function(highlights, colors) end,
})

vim.cmd.colorscheme 'tokyonight'
