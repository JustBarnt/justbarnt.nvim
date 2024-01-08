-- Set our preferred options
-- Get and active our keymaps
local keymaps = require("core.keymaps")
keymaps.init() -- Base keybinds

if not vim.g.vscode then
    require("core.options")
    require("core.autocmds")
    require("core.user_commands").Utils()
    require('core.largefile')
    --keymaps.plugins() -- run plugin related keybinds
    -- add in vim.g.vscode to prevent plugins from loading that don't work in vscode
    require("core.lazy") -- Setup Lazy plugin manager
    require("core.colorscheme") -- Set colorscheme
    -- require("core.autocmds") -- Set auto commands
end
