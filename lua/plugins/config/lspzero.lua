local maxFileSize = 40 * 1024 * 1024 -- 40mb in bytes, subject to be changedtick
local file_size
local function is_large_file()
    file_size = vim.fn.getfsize(vim.fn.expand("%"))
    return file_size > maxFileSize
end

if is_large_file() then
    vim.notify("LSP has been disabled due to large file size", vim.log.levels.INFO, { timeout = 3000} )
    return
end

local status_mason, mason = pcall(require, 'mason')
local status_mason_lsp, mason_lspconfig = pcall(require,'mason-lspconfig')
local status_lsp, lsp_zero = pcall(require, 'lsp-zero')

if not status_mason or not status_mason_lsp or not status_lsp then
    vim.print('One or more packages in lspzero.lua failed to load')
    return
end

local servers = {
    emmet_language_server = { filetypes = { 'html', 'svelte', 'astro', 'javascriptreact', 'typescriptreact', 'xml' } },
    intelephense = {},
    powershell_es = {},
    svelte = {},
    tailwindcss = {},
    tsserver = {},
    sqlls = { filetypes = { "sql", "mysql" } },
    html = { filetypes = { 'html', 'twig', 'hbs' } },
    lua_ls = {},
}

lsp_zero.extend_lspconfig()

lsp_zero.on_attach(function(client, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end

        vim.keymap.set('n', keys, func, {buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap("gd", require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    nmap("gr", require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap("gI", require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    nmap("<leader>D", require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
    nmap("<leader>ds", require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap("<leader>ws", require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

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

    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, {desc = 'Format current buffer with LSP '})
end)

mason.setup({})
mason_lspconfig.setup({
    ensure_installed = vim.tbl_keys(servers),
    handlers = {
        lsp_zero.default_setup,
        powershell_es = function()
            require('lspconfig').powershell_es.setup({
                cmd = { "pwsh", "-NoLogo", "-NoProfile", "-Command", vim.fn.stdpath('data') .. "/mason/packages/powershell-editor-services" }
            })
        end,
        lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
        tsserver = function()
            require('lspconfig').tsserver.setup({
                settings = {
                    completions = {
                        completeFunctionCalls = true
                    }
                }
            })
        end,
        intelephense = function()
            require('lspconfig').intelephense.setup({
                settings = {
                    intelephense = {
                        files = {
                            maxSize = 100000;
                        }
                    },
                    environment = {
                        includePaths = {
                            "C:\\PHP Plugins\\Cake2x",
                            "C:\\PHP Plugins\\Cake3x"
                        }
                    }
                }
            })
        end,        --[[sqlls = function()
            require('lspconfig').sqlls.setup({
                cmd = { vim.fn.stdpath('data') .. "/mason/packages/sqlls/node_modules/.bin/sql-language-server", "up", "--method", "stdio" },
                single_file_support  = true,
                root_dir = function(fname)
                    return require('lspconfig').util.root_pattern '*.sql'(fname)
                end,
           })
        end,]]
    }
})
