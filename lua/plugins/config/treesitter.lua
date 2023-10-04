local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
    print("treesitter did not load")
    return
end

treesitter.setup({
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 
        'c',
        'cpp',
        'lua',
        'tsx',
        "json",
        "html",
        "css",
        "gitignore",
        "yaml",
        "c_sharp",
        'javascript',
        'typescript',
        'vimdoc',
        'vim',
        'svelte'
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
