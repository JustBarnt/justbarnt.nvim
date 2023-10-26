-- Set our preferred options
require("core.options")



-- Get and active our keymaps
local keymaps = require("core.keymaps")
keymaps.init()

if vim.g.neovide then
    if not vim.g.vscode then
        keymaps.plugins()
        require 'core.neovide'
        -- add in vim.g.vscode to prevent plugins from loading that don't work in vscode

        require("core.lazy") -- Setup Lazy plugin manager
        require("core.colorscheme") -- Set colorscheme
        require("core.autocmds")
    end
end
