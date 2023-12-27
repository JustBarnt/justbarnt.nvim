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
