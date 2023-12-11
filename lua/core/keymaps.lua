local keymap = vim.keymap
local g = vim.g -- global settings

local map = function(mode, keys, func, desc)
    keymap.set(mode, keys, func, { desc = desc, silent = true })
end
-------------------------------------
--- General Keymaps (Run on Init) ---
-------------------------------------

local init = function()
    g.mapleader = " "
    g.maplocalleader = " "

    map("n", "<leader>sc", ':let @/ = ""<CR>')

    map("n", "<leader>ca", ":%y<CR>", "[C]opy [A]ll")

    -- Delete a single char without copying it into the register
    -- keymap.set("n", "x", '"_x', { silent = true })
    -- Swap letter to the right
    -- nmap("n", "xl", "xp")
    -- Fix keybind descrepancy between nvims builtin matchit (%) and nvim-comment plugin
    map("n", "_gc", "<cmd><C-U>call CommentOperator(visualmode())<CR>")

    -- Yank to EOL
    map("n", "Y", "y$")

    -- Center cursor when navigating search results
    map("n", "n", "nzz")
    map("n", "N", "Nzz")

    -- Center when joining lines
    map("n", "J", "mzJ`z")
    -- Move Between Panes: Useful for ToggleTerm if using Tabline (Open Buffers in Tabs like VSCode)
    map("n", "<C-h>", [[<Cmd>wincmd h<CR>]], "Move Pane: Left")
    map("n", "<C-j>", [[<Cmd>wincmd j<CR>]], "Move Pane: Down")
    map("n", "<C-k>", [[<Cmd>wincmd k<CR>]], "Move Pane: Up")
    map("n", "<C-l>", [[<Cmd>wincmd l<CR>]], "Move Pane: Right")

    -- Easy return to normal mode
    keymap.set("i", "jk", "<ESC>", { silent = true, desc = "Return to normal mode" })

    -- Move Line up and move line down in VISUAL MODE
    keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
    keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

    -- Split buffer
    map("n", "<leader>bv", ":vsplit <CR>")

    -- Close buffer(s)
    map("n", "<leader>x", "<cmd>bd<CR>", "Close Current Buffer")
    map("n", "<leader>X", "<cmd>bufdo bd<CR>", "Close All Buffers")

    -- Go back to File Explorer.
    -- I don't use Neotree becuase I'll be using harpoon
    map("n", "<leader>pv", vim.cmd.Ex, "Show File Explorer")

    map("n", "<leader>L", ":Lazy <CR>", "[L]azy Show")

    -- Source files
    map("n", "<F5>", ":so %<CR>", "Source Current File")

    -- EasyAlign
    map("x", "ga", vim.cmd.EasyAlign)
    map("n", "ga", vim.cmd.EasyAlign)
end

----------------------
--- Plugin keymaps ---
----------------------

local plugins = function()
    -- diff view
    map("n", "<leader>vd", ":DiffviewOpen<CR>", "View Diff")
    map("n", "<leader>nh", ":DiffviewFileHistory %<CR>", "View History")
end

-- Return keymap modules
return {
    init = init,
    plugins = plugins,
}
