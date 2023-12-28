return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local lualine = require("lualine")

        lualine.setup({
            options = {
                theme = "rose-pine",
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = {
                    {
                        "mode",
                    },
                },
                lualine_b = {
                    "branch",
                    "diff",
                    "diagnostics",
                },
                lualine_c = {
                    {
                        "filename",
                        path = 1,
                        -- 0: Just filename
                        -- 1: Relative Path
                        -- 2: Absolute Path
                        -- 3: Absolute path, with tilde as the home directory
                    },
                    {
                        "filetype",
                        icon_only = true,
                    },
                },
                lualine_x = { "encoding" },
                lualine_y = { "progress" },
                lualine_z = { "location", "searchcount" },
            },
        })
    end,
}
