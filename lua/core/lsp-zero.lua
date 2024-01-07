local installed = require("core.utils").found

local modules_installed = {
    lspzero_found = installed("lsp-zero"),
    neoconf = installed("neoconf"),
    neodev = installed("neodev"),
    mason = installed("mason"),
    mason_lspconfig = installed("mason-lspconfig"),
}

for module, found in ipairs(modules_installed) do
    if not found then
        print("Unabled to find " .. modules_installed[module] .. " cannot continue [LSP] setup")
        return nil
    end
end

local lsp = require("lsp-zero")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local neoconf = require("neoconf")
local neodev = require("neodev")
local opts = require('core.lsp.lsp-settings')


neoconf.setup(opts.neoconf)
neodev.setup(opts.neodev)
lsp.on_attach(function(client, bufnr)
    opts.on_attach(client, bufnr)
end)

mason.setup({})
mason_lspconfig.setup({
    opts.language_servers.ensure_installed,
})

local setup_servers = function(server, config)
    if not config then
        print("[ERROR] Config not found for: " .. server)
        return
    end

    if type(config) ~= "table" then
        config = {}
    end

    lspconfig[server].setup(config)
end

for server, config in pairs(opts.servers) do
    setup_servers(server, config)
end
