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

M.Harpoon = function()
    local ok, harpoon = pcall(require, 'harpoon')

    if not ok then
        vim.notify("Harpoon not found")
        return
    end

    vim.api.nvim_create_user_command("HarpoonAdd",
        function()
            harpoon:list():append()
            local file_name = vim.api.nvim_buf_get_name(0)
            vim.notify("Harpooned " .. file_name, vim.log.levels.INFO)
        end,
        { bang = true }
    )

    vim.api.nvim_create_user_command("HarpoonToggle",
        function()
             harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        { bang = true }
    )
end

M.Utils = function()
    vim.api.nvim_create_user_command("Trim", require("core.utils").trim, { bang = true })
    vim.api.nvim_create_user_command("LspFormat", function()
        require('conform').format({ async = true, lsp_fallback = true })
    end, { bang = true })
end

return M
