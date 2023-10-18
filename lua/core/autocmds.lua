local function augroup(name)
    return vim.api.nvim_create_augroup("justbarnt_" .. name, {clear = true})
end

local autocmd = vim.api.nvim_create_autocmd

autocmd({"BufEnter"}, {
    group = augroup("TitleRename"),
    pattern = "*",
    command = [[let &titlestring = "Neovim: " . expand("%:t")]]
})

autocmd({"VimEnter"}, {
    group = augroup("TitleRename"),
    pattern = "*",
    command = [[let &titlestring = "Neovim: " . expand("%:t")]]
})

autocmd({"VimEnter"}, {
    group = augroup("FontSet"),
    pattern = "*",
    command = [[set guifont=FiraCode_Nerd_Font_Mono_Ret:h12]]
})
