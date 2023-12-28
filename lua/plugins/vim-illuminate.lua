-- Highlights matching symbols under your cursor like in VSCode/VSE
-- Using my own fork for type defs
return {
    "justbarnt/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = { delay = 200 },
    lazy = false,
    config = function()
        local illuminate = require("illuminate")

        ---@class illuminate.config
        local config = {
            delay = 200,
        }

        illuminate.configure(config)
    end,
}
