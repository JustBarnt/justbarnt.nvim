local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
--

require("lazy").setup("plugins", {
    ui = {
        icons = {
            cmd = "",
            config = "",
            event = "",
            ft = "",
            init = "",
            keys = "",
            plugin = "",
            runtime = "",
            source = "",
            start = "",
            task = "",
        },
    },
    performance = {
        rtp = {
            disable_plugins = {
                "gzip",
                "matchit",
                "matchparan",
                --"netrwPlugin"
                "tarPlugin",
                "tohtml",
                "zipPlugin",
            },
        },
    },
})
