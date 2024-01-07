local M = {}

M.on_attach = function(client, bufnr)
    require("core.keymaps").lsp()
    local filetype = vim.api.nvim_buf_get_option(0, "filetype")

    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

    if client.server_capabilities.documentHighlightProvider then
        local augroup_highlight = vim.api.nvim_create_augroup("custom-lsp-references", { clear = true })
        vim.api.nvim_clear_autocmds({ group = augroup_highlight, buffer = bufnr })

        vim.api.nvim_create_autocmd({ "CursorHold" }, {
            callback = vim.lsp.buf.document_highlight,
            group = augroup_highlight,
            buffer = bufnr
        })

        vim.api.nvim_create_autocmd({ "CursorMoved" }, {
            callback = vim.lsp.buf.clear_references,
            group = augroup_highlight,
            buffer = bufnr
        })
    end

    if filetype == "typescript" or filetype == "lua" then
        client.server_capabilities.semanticTokensProvider = nil
    end
end

M.servers = {
    bashls = true,
    html = true,
    cmake = true,
    svelte = true,
    cssls = true,
    lua_ls = require("core.lsp.lua_ls"),
    intelephense = require("core.lsp.intelephense"),
    jsonls = require("core.lsp.jsonls"),
    clangd = require("core.lsp.clangd"),
    powershell_es = require('core.lsp.powershell_es'),
    emmet_language_server = require('core.lsp.emmet'),
    tsserver = require("core.lsp.tsserver"),
}

M.language_servers = {
    ensure_installed = {
        "bashls",
        "clangd",
        "cmake",
        "html",
        "intelephense",
        "jsonls",
        "lua_ls",
        "marksman",
        "powershell_es",
        "svelte",
        "tailwindcss",
        "taplo",
        "tsserver",
    }
}

M.formatters = {
    ensure_installed = {
        "stylua",
    }
}

M.neoconf = {
    opts = {
        imports = {
            vscode = false,
            coc = false,
            nlsp = false,
        }
    }
}

M.neodev = {
    library = {
        enabled = true,
        runtime = vim.env.VIMRUNTIME,
        plugins = vim.fn.stdpath("data") .. "\\lazy\\"
    },
    lspconfig = true,
    pathStrict = true,
}

return M
