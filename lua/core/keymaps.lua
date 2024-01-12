local keymap = vim.keymap
local g = vim.g -- global settings

local map = function(mode, keys, func, desc)
    if not desc then
        desc = nil
    end
    keymap.set(mode, keys, func, { desc = desc, silent = true })
end
-------------------------------------
--- General Keymaps (Run on Init) ---
-------------------------------------

local init = function()
    g.mapleader = " "
    g.maplocalleader = " "

    map("n", "<leader>sc", ':let @/ = ""<CR>')
    map("n", "Q", "<Nop>")
    map("n", "q", "<Nop>")
    -- Fix keybind descrepancy between nvims builtin matchit (%) and nvim-comment plugin
    map("n", "_gc", "<cmd><C-U>call CommentOperator(visualmode())<CR>")

    -- Yank to EOL
    map("n", "Y", "y$")

    -- Center cursor when navigating search results
    map("n", "n", "nzz")
    map("n", "N", "Nzz")

    -- Greatest remap ever - Name: theprimeagen
    map("x", "<leader>p", [["_dP]])

    map("i", "<C-b>", "<C-o>0")
    map("i", "<C-a>", "<C-o>A")

    -- Center when joining lines
    map("n", "J", "mzJ`z")
    -- Move Between Panes: Useful for ToggleTerm if using Tabline (Open Buffers in Tabs like VSCode)
    map({ "n", "t" }, "<C-h>", [[<Cmd>wincmd h<CR>]], "Move Pane: Left")
    map({ "n", "t" }, "<C-j>", [[<Cmd>wincmd j<CR>]], "Move Pane: Down")
    map({ "n", "t" }, "<C-k>", [[<Cmd>wincmd k<CR>]], "Move Pane: Up")
    map({ "n", "t" }, "<C-l>", [[<Cmd>wincmd l<CR>]], "Move Pane: Right")

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
local FTerm = function()
    map("t", "jk", [[<C-\><C-n>]], { silent = true })
    map("t", "<ESC>", [[<C-\><C-n>]], { silent = true })
    map("t", "<C-w>", [[<C-\><C-n><C-w>]], { silent = true })
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

-- LSP Keybinds
local lsp = function()
    local wk = require('which-key')
    local detour = require('detour').Detour

    local code_registers = wk.register(
        {
            c = {
                name = "[C]ode",
                a = { "<cmd>lua vim.lsp.buf.code_action<CR>", "Code Actions" },
                r = { "<cmd>lua vim.lsp.buf.rename<CR>", "Rename Symbol" },
                s = { "<cmd>lua vim.lsp.buf.signature_help<CR>", "Signature Help" },
            },
            g = {
                name = "[Go]-To LSP",
                d = {
                    function()
                        vim.lsp.buf.definition({ reuse_win = false })
                        detour()
                    end,
                    "[Go]-To [D]efinition"
                },
                D = {
                    function()
                        vim.lsp.buf.declaration({ reuse_win = false })
                        detour()
                    end,
                    "[Go]-To [D]eclaration"
                },
                I = {
                    function()
                        vim.lsp.buf.implementation({ reuse_win = false })
                        detour()
                    end,
                    "[Go]-To [I]mplementation"
                },
                T = {
                    function()
                        vim.lsp.buf.type_definition({ reuse_win = false })
                        detour()
                    end,
                    "[Go]-To [T]ype Definition"
                }
            },
            r = {
                name = "LSP Restart",
                r = { "<CMD>LspRestart<CR>", "LSP Restart" }
            }
        }, { prefix = "<leader>" })


    vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "lsp:hover" })

    -- vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename)
    -- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

    -- vim.keymap.set("n", "gd", function()
    --     vim.lsp.buf.definition({ reuse_win = false })
    --     require("detour").Detour()
    -- end, { desc = "Goto Defintion" })
    --
    -- vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
    -- vim.keymap.set("n", "gT", vim.lsp.buf.type_definition)

    -- vim.keymap.set("n", "<leader>gI", vim.lsp.buf.implementation)
    -- vim.keymap.set("n", "<leader>rr", "LspRestart")
end

-- Return keymap modules
return {
    init = init,
    FTerm = FTerm,
    telescope = telescope,
    lsp = lsp
}

