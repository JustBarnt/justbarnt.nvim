-- Set our preferred options
require("core.options")
require("core.autocmds")
-- Get and active our keymaps
local keymaps = require("core.keymaps")
keymaps.init() -- Base keybinds

if not vim.g.vscode then
    --keymaps.plugins() -- run plugin related keybinds
    -- add in vim.g.vscode to prevent plugins from loading that don't work in vscode
    require("core.lazy") -- Setup Lazy plugin manager
    require("core.colorscheme") -- Set colorscheme
    -- require("core.autocmds") -- Set auto commands
end
