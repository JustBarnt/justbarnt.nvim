local status, discord = pcall(require, 'presence')

if not status then
    vim.notify('Nvim Configuration Reloaded', vim.log.levels.WARN)
    return
end

discord.setup({})
