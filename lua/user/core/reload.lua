function _G.ReloadConfig()
    for name, _ in pairs(package.loaded) do
        if name:match("^core") then
            package.loaded[name] = nil
        end
    end

    dofile(vim.env.MYVIMRC)
    vim.notify('Nvim Configuration Reloaded', vim.log.levels.INFO)
end
