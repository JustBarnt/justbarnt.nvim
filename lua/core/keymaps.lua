local keymap = vim.keymap
local g = vim.g -- global settings

local nmap = function(keys, func, desc)
    if desc then
        desc = "LSP:" .. desc
    end

    keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
end
-------------------------------------
--- General Keymaps (Run on Init) ---
-------------------------------------

local init = function()
    g.mapleader = " "
    g.maplocalleader = " "

    -- Delete a single char without copying it into the register
    keymap.set("n", "x", '"_x')
    -- Fix keybind descrepancy between nvims builtin matchit (%) and nvim-comment plugin
    keymap.set("n", "_gc", "<cmd><C-U>call CommentOperator(visualmode())<CR>")

    -- Yank to EOL
    keymap.set("n", "Y", "y$")

    -- Center cursor when navigating search results
    keymap.set("n", "n", "nzz")
    keymap.set("n", "N", "Nzz")

    -- Center when joining lines
    keymap.set("n", "J", "mzJ`z")

    -- Move Line up and move line down in VISUAL MODE
    keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
    keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

    -- Close buffer(s)
    keymap.set("n", "<leader>x", "<cmd>bd<CR>", { desc = "Close Current Buffer" })
    keymap.set("n", "<leader>X", "<cmd>bufdo bd<CR>", { desc = "Close All Buffers" })

    -- Go back to File Explorer.
    -- I don't use Neotree becuase I'll be using harpoon
    keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Show File Explorer" })

    -- Source files
    keymap.set("n", "<leader><leader>", function()
        vim.cmd("so")
    end)
end

----------------------
--- Plugin keymaps ---
----------------------

local plugins = function()
    --GIT SIGNS
    -- TODO

    -- diff view
    keymap.set("n", "<leader>vd", ":DiffviewOpen<CR>", { desc = "View Diff" })
    keymap.set("n", "<leader>nh", ":DiffviewFileHistory %<CR>", { desc = "View History" })
 
    -- Comment
    -- TODO
end

-- Return keymap modules
return {
    init = init,
    plugins = plugins,
}
