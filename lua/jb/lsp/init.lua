local neodev = vim.F.npcall(require, "neodev")

if neodev then
    neodev.setup {
        override = function(_, library)
            library.enabled = true
            library.plugins = true
        end,
        lspconfig = true,
        pathStrict = true,
    }
end

local lspconfig = vim.F.npcall(require, "lspconfig")

if not lspconfig then
    return
end
local remap = require('core.utils').remap

local handlers = require "jb.lsp.handlers"
local ts_util = require "nvim-lsp-ts-utils"
local inlays = require "jb.lsp.inlay"

local custom_init = function(client)
    client.config.flags = client.config.flags or {}
    client.config.flags.allow_incremental_sync = true
end

local augroup_highlight = vim.api.nvim_create_augroup("custom-lsp-references", { clear = true })
local augroup_codelens = vim.api.nvim_create_augroup("custom-lsp-codelens", { clear = true })

local filetype_attach = setmetatable({}, {
    {
        __index = function()
            return function() end
        end,
    }
})

local custom_attach = function(client, bufnr)
    if client.name == "copilot" then
        return
    end

    local filetype = vim.api.nvim_buf_get_option(0, "filetype")

    remap { "i", "<c-s>", vim.lsp.buf.signature_help }

    remap { "n", "<space>cr", vim.lsp.buf.rename }
    remap { "n", "<space>ca", vim.lsp.buf.code_action }

    remap { "n", "gd", vim.lsp.buf.definition }
    remap { "n", "gD", vim.lsp.buf.declaration }
    remap { "n", "gT", vim.lsp.buf.type_definition }
    remap { "n", "K", vim.lsp.buf.hover, { desc = "lsp:hover" } }

    remap { "n", "<space>gI", handlers.implementation }
    remap { "n", "<space>lr", "<cmd>lua R('jb.lsp.codelens').run()<CR>" }
    remap { "n", "<space>rr", "LspRestart" }

    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

    if filetype == "typescript" or filetype == "lua" then
        client.server_capabilities.semanticTokensProvider = nil
    end

    -- Attach filetype specific options
    filetype_attach[filetype]()
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities.textDocument.completion.completionItem.snippetSupport = true
updated_capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

-- Completion Configuration
vim.tbl_deep_extend("force", updated_capabilities, require("cmp_nvim_lsp").default_capabilities())
updated_capabilities.textDocument.completion.completionItem.insertReplaceSupport = false
updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }

local servers = {
    -- Also uses `shellcheck` and `explainshell`
    bashls = true,
    lua_ls = {
        Lua = {
            workspace = {
                checkThirdParty = false,
            },
        },
    },

    gdscript = true,
    -- graphql = true,
    html = true,
    vimls = true,
    yamlls = true,
    -- Enable jsonls with json schemas
    jsonls = {
        settings = {
            json = {
                schemas = require("schemastore").json.schemas(),
                validate = { enable = true },
            },
        },
    },

    cmake = (1 == vim.fn.executable "cmake-language-server"),

    clangd = {
        cmd = {
            "clangd",
            "--background-index",
            "--suggest-missing-includes",
            "--clang-tidy",
            "--header-insertion=iwyu",
        },
        init_options = {
            clangdFileStatus = true,
        },
        filetypes = {
            "c",
        },
    },

    svelte = true,

    --[[omnisharp = {
    cmd = { vim.fn.expand "~/build/omnisharp/run", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
  },]]

    cssls = true,

    -- eslint = true,
    tsserver = {
        init_options = ts_util.init_options,
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
        },

        on_attach = function(client)
            custom_attach(client)

            ts_util.setup { auto_inlay_hints = false }
            ts_util.setup_client(client)
        end,
    },
}

require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls", "jsonls" },
}

local setup_server = function(server, config)
    if not config then
        return
    end

    if type(config) ~= "table" then
        config = {}
    end

    config = vim.tbl_deep_extend("force", {
        on_init = custom_init,
        on_attach = custom_attach,
        capabilities = updated_capabilities,
    }, config)

    lspconfig[server].setup(config)
end

for server, config in pairs(servers) do
    setup_server(server, config)
end

-- Only run stylua when we can find a root dir
require("conform.formatters.stylua").require_cwd = true

require("conform").setup {
    formatters_by_ft = {
        lua = { "stylua" },
        typescript = { { "prettierd", "prettier" } },
        javascript = { { "prettierd", "prettier" } },
    },
}

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        require("conform").format { bufnr = args.buf, lsp_fallback = true }
    end,
})

return {
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = updated_capabilities,
}

