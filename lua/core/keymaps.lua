local keymap = vim.keymap
local g = vim.g -- global settings
-------------------------------------
--- General Keymaps (Run on Init) ---
-------------------------------------

local init = function()
    g.mapleader = " "
    g.maplocalleader = " "

    -- Use ESC to turn off search highlighting
    keymap.set("n", "<ESC>", "<cmd>nohlsearch<CR>")

    -- Delete a single char without copying it into the register
    keymap.set("n", "x", '"_x')

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

    -- Delete without storing in register
    keymap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without storing in Register" })

    -- Close buffer(s)
    keymap.set("n", "<leader>x", "<cmd>bd<CR>", { desc = "Close Current Buffer" })
    keymap.set("n", "<leader>X", "<cmd>bufdo bd<CR>", { desc = "Close All Buffers" })

    -- tab management
    keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Tab Open (new)" })
    keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Tab X (close)" })
    keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Tab Next" })
    keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Tab Previous" })

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

-----------------------------------------------------
--- LSP Attach Keymaps (Only when LSP is running) ---
-----------------------------------------------------

local lsp_on_attach = function()
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end

-- Return keymap modules
return {
    init = init,
    plugins = plugins,
    lsp_on_attach = lsp_on_attach,
}
