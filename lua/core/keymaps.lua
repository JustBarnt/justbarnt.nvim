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
    map("n", "<leader><F5>", function()
        --save files
        vim.cmd.w()
        -- if lua file and we're in 'nvim/' dir: we :so the file
        local current_file_path = vim.api.nvim_buf_get_name(0)
        local in_config = current_file_path:find("^" .. vim.fn.stdpath("config")) ~= nil
        local is_lua = current_file_path:find(".lua$") ~= nil

        if in_config and is_lua then
            vim.cmd.so()
        end
    end, "Source Current File")

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

local telescope = function()
    local tm = require("core.telescope_modules")
    vim.keymap.set("n", "<leader>gf", tm.builtin.git_files, { desc = "Search [G]it [F]iles" })
    vim.keymap.set("n", "<leader>sf", tm.builtin.find_files, { desc = "[S]earch [F]iles" })
    vim.keymap.set("n", "<leader>sh", tm.builtin.help_tags, { desc = "[S]earch [H]elp" })
    vim.keymap.set("n", "<leader>sw", tm.builtin.grep_string, { desc = "[S]earch current [W]ord" })
    vim.keymap.set("n", "<leader>sg", tm.builtin.live_grep, { desc = "[S]earch by [G]rep" })
    vim.keymap.set("n", "<leader>sd", tm.builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
    vim.keymap.set("n", "<leader>sr", tm.builtin.resume, { desc = "[S]earch [R]esume" })

    -- TODO: Add in file browser keymaps
end

-- Return keymap modules
return {
    init = init,
    plugins = plugins,
    telescope = telescope,
}
