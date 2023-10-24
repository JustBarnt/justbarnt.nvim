local alpha = function()
    return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
end

-- Set font for neovide. Ligatures are enabled by default.
vim.o.guifont = "CaskaydiaCove NF:h14"

--Configured neovide background opacity
vim.g.transparency = 0.95
vim.g.neovide_transparency = 0.95
vim.g.neovide_background_color = "#190e2e" .. alpha();

vim.opt.linespace = 1;
vim.g.neovide_theme = 'dark'
vim.g.neovide_remember_window_size = true
vim.g.neovide_cursor_animation_length = 0.05
vim.g.neovide_cursor_trail_size = 0.4
vim.g.neovide_cursor_vfx_mode = 'wireframe'
vim.g.neovide_cursor_vfx_particle_density = 3.5
vim.g.neovide_cursor_vfx_particle_speed = "5.0"
vim.g.neovide_floating_blur_amount_x = 0.8
vim.g.neovide_floating_blur_amount_y = 0.8
