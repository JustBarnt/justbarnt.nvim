local maxFileSize = 40 * 1024 * 1024 -- 40mb in bytes, subject to be changedtick
local file_size
local function is_large_file()
    file_size = vim.fn.getfsize(vim.fn.expand("%"))

    return file_size > maxFileSize
end

if is_large_file() then
    vim.notify("TreeSitter has been disabled to due large file size")
    return
end


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
    autotag = { enable = is_large_file() }, -- enable autotagging with nvim-ts-autotag
    highlight = { enable = is_large_file() },
    indent = { enable = is_large_file() },
})

