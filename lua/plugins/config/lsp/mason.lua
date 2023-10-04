local mason_status, mason = pcall(require, "mason")
if not mason_status then
	print("mason did not load")
	return
end

-- enable mason
mason.setup()

-- import mason-lspconfig plugin safely
local mason_lsp_config_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lsp_config_status then
	print("mason-lspconfig did not load")
	return
end

local servers = require("plugins.config.lsp.servers")

mason_lspconfig.setup({
	-- list of servers for mason to install
	ensure_installed = vim.tbl_keys(servers.servers),
	-- auto-install configured servers (with lspconfig)
	automatic_installation = true, -- not the same as ensure_installed
})

-- import mason-tool-installer plugin safely
local mason_tool_installer_status, mason_tool_installer = pcall(require, "mason-tool-installer")
if not mason_tool_installer_status then
	print("mason-tool-installer did not load")
	return
end

-- enable mason tool installer
mason_tool_installer.setup({
	ensure_installed = {
		"prettierd",
		"stylua",
	},
})
