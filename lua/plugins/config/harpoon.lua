local status, harpoon = pcall(require, 'harpoon')
local mark = require('harpoon.mark')
local ui = require('harpoon.ui')
if not status then
    print('harpon did not load')
    return
end

 -- Harpoon
    vim.keymap.set("n", "<leader>ha", mark.add_file, {desc = "[A]dd File"})
    vim.keymap.set("n", "<leader>ht", ui.toggle_quick_menu, { desc = "[T]oggle UI"})
    vim.keymap.set("n", "<leader>hq", function() ui.nav_file(1) end, { desc = "Jump To File 1"})
    vim.keymap.set("n", "<leader>hw", function() ui.nav_file(2) end, { desc = "Jump To File 2"})
    vim.keymap.set("n", "<leader>he", function() ui.nav_file(3) end, { desc = "Jump To File 3"})
    vim.keymap.set("n", "<leader>hr", function() ui.nav_file(4) end, { desc = "Jump To File 4"})

