require("nvim-treesitter.configs").setup({
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = {
        "c",
        "cmake",
        "cpp",
        "lua",
        "tsx",
        "json",
        "html",
        "css",
        "gitcommit",
        "php",
        "sql",
        "gitignore",
        "yaml",
        "c_sharp",
        "javascript",
        "typescript",
        "vimdoc",
        "vim",
        "svelte",
        "regex",
        "bash",
        "markdown",
        "markdown_inline"

    },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = true,
    autotag = { enable = true }, -- enable autotagging with nvim-ts-autotag
    highlight = { enable = true },
    indent = { enable = true },
})

vim.treesitter.query.set("javascript", "injections", "")
vim.treesitter.query.set("typescript", "injections", "")
vim.treesitter.query.set("tsx", "injections", "")
vim.treesitter.query.set("lua", "injections", "")
