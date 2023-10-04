-- Set up LSP servers with the same config
local servers = {
  -- cmake = {},
  -- csharp_ls = {},
  emmet_language_server = { filetypes = { 'html', 'svelte', 'astro', 'javascriptreact', 'typescriptreact', 'xml' } },
  intelephense = {},
  powershell_es = { bundle_path = "c:/PowerShellEditor/PowerShellEditorServices/" },
  svelte = {},
  tailwindcss = {},
  tsserver = {},
  html = { filetypes = { 'html', 'twig', 'hbs' } },

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

return {
    servers = servers
}
