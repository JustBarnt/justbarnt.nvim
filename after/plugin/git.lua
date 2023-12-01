---[[ - ]] vim.fn["gina#custom#command#option"]('status', '--opener', 'vsplit')
-- nnoremap { '<leader>gs', '<cmd>Gina status<CR>' }

local ok, neogit = pcall(require, "neogit")
if not ok then
    return
end

local gs_ok, gitsigns = pcall(require, "gitsigns")
if not ok then
    return
end

gitsigns.setup({
    signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
    },
})

neogit.setup({
    integrations = {
        diffview = true,
    },
})

vim.keymap.set("n", "<space>vv", ":DiffviewOpen<CR>", { desc = "Diff View Open" })

vim.keymap.set("n", "<leader>gs", neogit.open, { desc = "[G]it [S]tatus" })
vim.keymap.set("n", "<leader>gc", function()
    neogit.open({ "commit" })
end, {
    desc = "[G]it [C]ommit",
})

-- hi NeogitNotificationInfo guifg=#80ff95
-- hi NeogitNotificationWarning guifg=#fff454
-- hi NeogitNotificationError guifg=#c44323
-- hi def NeogitDiffAddHighlight guibg=#404040 guifg=#859900
-- hi def NeogitDiffDeleteHighlight guibg=#404040 guifg=#dc322f
-- hi def NeogitDiffContextHighlight guibg=#333333 guifg=#b2b2b2
-- hi def NeogitHunkHeader guifg=#cccccc guibg=#404040
-- hi def NeogitHunkHeaderHighlight guifg=#cccccc guibg=#4d4d4d

-- git config --global merge.conflictStyle diff3
