local keymap = vim.keymap
local g = vim.g -- global settings

local nmap = function(mode, keys, func, desc)
    keymap.set(mode, keys, func, { desc = desc, silent = true })
end
-------------------------------------
--- General Keymaps (Run on Init) ---
-------------------------------------

local init = function()
    g.mapleader = " "
    g.maplocalleader = " "

    nmap("n", "<leader>sc", ':let @/ = ""<CR>')

    -- Delete a single char without copying it into the register
    -- keymap.set("n", "x", '"_x', { silent = true })
    -- Swap letter to the right
    -- nmap("n", "xl", "xp")
    -- Fix keybind descrepancy between nvims builtin matchit (%) and nvim-comment plugin
    nmap("n", "_gc", "<cmd><C-U>call CommentOperator(visualmode())<CR>")

    -- Yank to EOL
    nmap("n", "Y", "y$")

    -- Center cursor when navigating search results
    nmap("n", "n", "nzz")
    nmap("n", "N", "Nzz")

    -- Center when joining lines
    nmap("n", "J", "mzJ`z")

    -- Move Between Panes: Useful for ToggleTerm if using Tabline (Open Buffers in Tabs like VSCode)
    nmap("n", "<C-h>", [[<Cmd>wincmd h<CR>]], "Move Pane: Left")
    nmap("n", "<C-j>", [[<Cmd>wincmd j<CR>]], "Move Pane: Down")
    nmap("n", "<C-k>", [[<Cmd>wincmd k<CR>]], "Move Pane: Up")
    nmap("n", "<C-l>", [[<Cmd>wincmd l<CR>]], "Move Pane: Right")

    -- Easy return to normal mode
    keymap.set("i", "jk", "<ESC>", { silent = true, desc = "Return to normal mode" })

    -- Move Line up and move line down in VISUAL MODE
    keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
    keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

    -- Split buffer
    keymap.set("n", "<leader>bv", ":vsplit <CR>", { silent = true })

    -- Close buffer(s)
    nmap("n", "<leader>x", "<cmd>bd<CR>", "Close Current Buffer")
    nmap("n", "<leader>X", "<cmd>bufdo bd<CR>", "Close All Buffers")

    -- Go back to File Explorer.
    -- I don't use Neotree becuase I'll be using harpoon
    nmap("n", "<leader>pv", vim.cmd.Ex, "Show File Explorer")

    -- Move Between Panes

    -- Source files
    nmap("n", "<leader>S", function()
        vim.cmd("so")
    end)

    -- EasyAlign
    nmap("x", "ga", vim.cmd.EasyAlign)
    nmap("n", "ga", vim.cmd.EasyAlign)
end

----------------------
--- Plugin keymaps ---
----------------------

local plugins = function()
    -- diff view
    nmap("n", "<leader>vd", ":DiffviewOpen<CR>", "View Diff")
    nmap("n", "<leader>nh", ":DiffviewFileHistory %<CR>", "View History")
end

-- Return keymap modules
return {
    init = init,
    plugins = plugins,
}
