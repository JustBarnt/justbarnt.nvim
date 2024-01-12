local M = {}

M.register = {
    ["<leader>s"] = {
        name = "Telescope Search",
        gf = { "<CMD>Telescope git_files<CR>", "Search Git Files" },
        f = { "<CMD>Telescope find_files<CR>", "Search Files" },
        h = { "<CMD>Telescope help_tags<CR>", "Search Help Tags" },
        w = { "<CMD>Telescope grep_string<CR>", "Search with Grep" },
        g = { "<CMD>Telescope live_grep<CR>", "Search Files W/Grep" },
        d = { "<CMD>Telescope diagnostics<CR>", "Search Diagnostics" },
        r = { "<CMD>Telescope resume<CR>", "Resume Search" },
        b = { "<CMD>Telescope file_browser path=%p:h grouped=true use_fd=true select_buffer=true<CR>", "File Browser" },
    }
}

return M

