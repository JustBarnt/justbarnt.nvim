-- Set our preferred options
require("user.core.options")

if vim.g.neovide then
    require('user.core.neovide')
end

-- Get and active our keymaps
local keymaps = require("user.core.keymaps")
keymaps.init()

if not vim.g.vscode then
    keymaps.plugins()
    -- add in vim.g.vscode to prevent plugins from loading that don't work in vscode
    require("user.core.lazy") -- Setup Lazy plugin manager
    require("user.core.colorscheme") -- Set colorscheme
    require("user.core.autocmds")
end
