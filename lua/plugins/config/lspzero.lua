require 'utils'

local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')
local lsp_zero = Status_Ok('lsp-zero')


if lsp_zero == nil or mason == nil or mason_lspconfig == nil then
    Log('One or more packages in lspzero.lua failed to load')
    print('One or more packages in lspzero.lua failed to load')
    return
end

local servers = {
    emmet_language_server = { filetypes = { 'html', 'svelte', 'astro', 'javascriptreact', 'typescriptreact', 'xml' } },
    intelephense = {},
    powershell_es = {},
    svelte = {},
    tailwindcss = {},
    tsserver = {},
    html = { filetypes = { 'html', 'twig', 'hbs' } },
    lua_ls = {},
}

lsp_zero.extend_lspconfig()

lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({buffer = bufnr})
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
        end,
    }
})
