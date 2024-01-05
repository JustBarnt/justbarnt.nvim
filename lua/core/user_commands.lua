local M = {}

M.FTerm = function()
    -- Opens the terminal
    vim.api.nvim_create_user_command("FTermOpen", require("FTerm").open, { bang = true })

    -- Close terminal (Preserves session)
    vim.api.nvim_create_user_command("FTermClose", require("FTerm").close, { bang = true })

    -- Exit terminal (Does not preserve session)
    vim.api.nvim_create_user_command("FTermExit", require("FTerm").exit, { bang = true })

    -- Toggles terminal
    vim.api.nvim_create_user_command("FTermToggle", require("FTerm").toggle, { bang = true })

    --[[  
    For furture refernce commands can also be ran using FTerm by using 
    require('FTerm').run('[COMMAND]')
  ]]
end

M.Utils = function()
    vim.api.nvim_create_user_command("Trim", require("core.utils").trim, { bang = true })
end

return M
