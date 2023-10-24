-- Set our preferred options
require("core.options")



-- Get and active our keymaps
local keymaps = require("core.keymaps")
keymaps.init()
keymaps.plugins()

if vim.g.neovide then
    require 'core.neovide'
end
-- add in vim.g.vscode to prevent plugins from loading that don't work in vscode

require("core.lazy") -- Setup Lazy plugin manager
require("core.colorscheme") -- Set colorscheme
require("core.autocmds")
