require("utils")

local servers = {
    emmet_language_server = { filetypes = { 'html', 'svelte', 'astro', 'javascriptreact', 'typescriptreact', 'xml' } },
    intelephense = {},
    powershell_es = { bundle_path = "c:/PowerShellEditor/PowerShellEditorServices/" },
    svelte = {},
    tailwindcss = {},
    tsserver = {},
    html = { filetypes = { 'html', 'twig', 'hbs' } },
    lua_ls = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = { checkThirdPart = false },
            telemetry = { enabled = false },
        }
    },
}


local lspzero = Status_Ok('lsp-zero')
local cmp = Status_Ok("cmp")

if lspzero == nil or cmp == nil then
    Log("A package failed to be required" .. lspzero .. "\n" .. cmp)
    return
end

lspzero.preset("recommended")
lspzero.nvim_workspace()
lspzero.ensure_installed(vim.tbl_keys(servers))

lspzero.set_preferences({
    sign_icons = {
        error = "E",
        warn = "W",
        hint = "H",
        info = "I"
    }
})
