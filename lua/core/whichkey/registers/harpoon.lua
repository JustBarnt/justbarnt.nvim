local M = {}

local harpoon = require 'harpoon'

M.register = {
    ["<leader>h"] = {
        name = "Harpoon", -- The name? Harpoonagen
        a = { "<CMD>HarpoonAdd<CR>", "Add File to Harpoon" },
        l = { "<CMD>HarpoonToggle<CR>", "Show Harpoon List" },
    },
    ["1"] = {
        function()
            harpoon:list():select(1)
        end,
        "Harpoon: Jump To File: 1"
    },
    ["2"] = {
        function()
            harpoon:list():select(2)
        end,
        "Harpoon: Jump To File: 2"
    },
    ["3"] = {
        function()
            harpoon:list():select(3)
        end,
        "Harpoon: Jump To File: 3"
    },
    ["4"] = {
        function()
            harpoon:list():select(4)
        end,
        "Harpoon: Jump To File: 4"
    },
    ["5"] = {
        function()
            harpoon:list():select(5)
        end,
        "Harpoon: Jump To File: 5"
    }
}

return M

