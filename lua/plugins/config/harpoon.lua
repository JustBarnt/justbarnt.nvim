local status, harpoon = pcall(require, 'harpoon')
local mark = require('harpoon.mark')
local ui = require('harpoon.ui')
if not status then
    print('harpon did not load')
    return
end

local map = function(keys, func, desc)
    if desc then
        desc = 'HARP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { desc = desc })
end

map('<leader>a', mark.add_file, '[A]dd File')
map('<leader>e', ui.toggle_quick_menu, 'Toggl[e] Quick Menu')

map('<C-h>', function() ui.nav_file(1) end, 'View Harpooned: 1')
map('<C-t>', function() ui.nav_file(2) end, 'View Harpooned: 2')
map('<C-n>', function() ui.nav_file(3) end, 'View Harpooned: 3')
map('<C-s>', function() ui.nav_file(3) end, 'View Harpooned: 4')
