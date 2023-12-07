local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup({})
-- REQUIRED

-- Append current open file to our harpon list
vim.keymap.set("n", "<leader>ha", function()
    harpoon:list():append()
end, { desc = "[H]arpoon [A]dd", silent = true })

-- Toggle a UI popup of or current harpooned items.
vim.keymap.set("n", "<leader>hl", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "[H]arpoon [L]ist", silent = true })

for i = 1, 5 do
    vim.keymap.set("n", string.format("<space>%s", i), function()
        harpoon:list():select(i)
    end, { desc = "Harpoon: Jump To File: " .. i, silent = true })
end
