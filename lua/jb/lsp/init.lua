local neodev = vim.F.npcall(require, "neodev")

if neodev then
    neodev.setup({
        override = function(_, library)
            library.enabled = true
            library.plugins = true
        end,
        lspconfig = true,
        pathStrict = true,
    })
end

local lspconfig = vim.F.npcall(require, "lspconfig")

if not lspconfig then
    return
end

local remap = require("core.utils").remap

local autocmd = require("jb.auto")
local autocmd_clear = vim.api.nvim_clear_autocmds
local handlers = require("jb.lsp.handlers")
local ts_util = require("nvim-lsp-ts-utils")
local inlays = require("jb.lsp.inlay")

local custom_init = function(client)
    client.config.flags = client.config.flags or {}
    client.config.flags.allow_incremental_sync = true
end

local augroup_highlight = vim.api.nvim_create_augroup("custom-lsp-references", { clear = true })
local augroup_codelens = vim.api.nvim_create_augroup("custom-lsp-codelens", { clear = true })

local filetype_attach = setmetatable({}, {
    {
        --[[ intelephense = function()
            autocmd_clear({ group = augroup_codelens, buffer = 0 })
            autocmd({
                { "bufenter", "bufwritepost", "cursorhold" },
                augroup_codelens,
                require("jb.lsp.codelens").refresh_virtlines,
                0,
            })

            vim.keymap.set(
                "n",
                "<leader>tt",
                require("jb.lsp.codelens").toggle_virtlines,
                { silent = true, desc = "[t]oggle [t]ypes", buffer = 0 }
            )
        end, ]]
        __index = function()
            return function() end
        end,
    },
})

local custom_attach = function(client, bufnr)
    if client.name == "copilot" then
        return
    end

    local filetype = vim.api.nvim_buf_get_option(0, "filetype")

    remap({ "i", "<c-s>", vim.lsp.buf.signature_help })

    remap({ "n", "<leader>cr", vim.lsp.buf.rename })
    remap({ "n", "<leader>ca", vim.lsp.buf.code_action })

    remap({ "n", "gd", vim.lsp.buf.definition })
    remap({ "n", "gD", vim.lsp.buf.declaration })
    remap({ "n", "gT", vim.lsp.buf.type_definition })
    remap({ "n", "K", vim.lsp.buf.hover, { desc = "lsp:hover" } })

    remap({ "n", "<leader>gI", handlers.implementation })
    remap({ "n", "<leader>lr", "<cmd>lua R('jb.lsp.codelens').run()<CR>" })
    remap({ "n", "<leader>rr", "LspRestart" })

    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.documentHighlightProvider then
        autocmd_clear({ group = augroup_highlight, buffer = bufnr })
        autocmd({ "CursorHold", augroup_highlight, vim.lsp.buf.document_highlight, bufnr })
        autocmd({ "CursorMoved", augroup_highlight, vim.lsp.buf.clear_references, bufnr })
    end

    if false and client.server_capabilities.codeLensProvider then
        if filetype ~= "elm" then
            autocmd_clear({ group = augroup_codelens, buffer = bufnr })
            autocmd({ "BufEnter", augroup_codelens, vim.lsp.codelens.refresh, bufnr, once = true })
            autocmd({ { "BufWritePost", "CursorHold" }, augroup_codelens, vim.lsp.codelens.refresh, bufnr })
        end
    end

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
updated_capabilities.textDocument.codeLens = { dynamicRegistration = true }

local servers = {
    -- Also uses `shellcheck` and `explainshell`
    bashls = true,
    lua_ls = {
        Lua = {
            workspace = {
                checkThirdParty = false,
            },
            hint = {
                enable = true,
            },
            diagnostics = {
                disable = {
                    "missing-fields",
                    "incomplete-signature-doc",
                },
            },
        },
    },
    intelephense = {
        settings = {
            environment = {
                includePaths = {
                    "C:/PHP/includes/Cake",
                },
            },
        },
    },
    gdscript = true,
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

    cmake = (1 == vim.fn.executable("cmake-language-server")),

    clangd = {},
    powershell_es = {
        bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",
        shell = "pwsh.exe",
        --[[ cmd = {
            "pwsh",
            "-NoLogo",
            "-NoProfile",
            "-Command",
            vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",
        }, ]]
        root_dir = function(fname)
            local path = require("lspconfig").util.root_pattern("*_profile.ps1") or "*.ps1"
            return path(fname)
        end,
        single_file_support = true,
    },
    svelte = true,

    --[[omnisharp = {
    cmd = { vim.fn.expand "~/build/omnisharp/run", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
  },]]

    cssls = true,
    emmet_language_server = { filetypes = { "html", "svelte", "astro", "javascriptreact", "typescriptreact", "xml" } },
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

            ts_util.setup({ auto_inlay_hints = false })
            ts_util.setup_client(client)
        end,
    },
}

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "jsonls" },
})

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

require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        typescript = { { "prettierd", "prettier" } },
        javascript = { { "prettierd", "prettier" } },
    },
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        require("conform").format({ bufnr = args.buf, lsp_fallback = false })
    end,
})

return {
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = updated_capabilities,
}
