local status, lualine = pcall(require, "lualine")
if not status then
    print("lualine did not load")
    return
end

lualine.setup({
    options = {
        theme = 'tokyonight',
    },
    sections = { 
        lualine_a = {
            {
                "mode",
            },
        },
        lualine_b = {
            "branch", "diff", "diagnostics"
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
                icon_only = true
            },
        },
        lualine_x = { "encoding" },
        lualine_y = { "progress" },
        lualine_z = { "location", "searchcount" },
    }
})
