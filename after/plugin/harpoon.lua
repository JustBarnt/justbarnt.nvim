local status, harpoon = pcall(require, "harpoon")

if not status then
    return
end

-- REQUIRED
harpoon.setup()
-- REQUIRED

vim.keymap.set("n", "<leader>ha", function()
    require("harpoon.mark").add_file()
end, { desc = "[H]arpoon [A]dd" })

vim.keymap.set("n", "<leader>hl", function()
    require("harpoon.ui").toggle_quick_menu()
end, { desc = "[H]arpoon [L]ist" })

for i = 1, 5 do
    vim.keymap.set("n", string.format("<space>%s", i), function()
        require("harpoon.ui").nav_file(i)
    end, {
        desc = "Harpoon: Jump To File: " .. i,
    })
end
