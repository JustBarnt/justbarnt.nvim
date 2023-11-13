local alpha = function()
    return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
end

-- Set font for neovide. Ligatures are enabled by default.
vim.o.guifont = "Monaspace Krypton:h34"
vim.g.neovide_scale_factor = 0.38

--Configured neovide background opacity
vim.g.transparency = 0.95
vim.g.neovide_transparency = 0.95
vim.g.neovide_background_color = "#190e2e" .. alpha();

vim.opt.linespace = 1;
vim.g.neovide_theme = 'dark'
vim.g.neovide_remember_window_size = true
vim.g.neovide_cursor_animation_length = 0
vim.g.neovide_cursor_trail_length = 0
