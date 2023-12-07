---@diagnostic disable: unused-local, unused-function

local has_dap, dap = pcall(require, "dap")
if not has_dap then
    return
end

vim.fn.sign_define("DapBreakpoint", { text = "ß", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "ü", texthl = "", linehl = "", numhl = "" })
-- Setup cool Among Us as avatar
vim.fn.sign_define("DapStopped", { text = "ඞ", texthl = "Error" })

require("nvim-dap-virtual-text").setup({
    enabled = true,
    enable_commands = false,
    highlight_changed_variables = true,
    highlight_new_as_changed = true,
    commented = false,
    show_stop_reason = true,
    -- Experimental features:
    virt_text_pos = "eol",
    all_frames = false,
})

dap.defaults.fallback.external_terminal = {
    command = "C:/Program Files/WezTerm",
    args = { "-e" },
}

dap.adapters.nlua = function(callback, config)
    callback = { type = "server", host = config.host, port = config.port }
end

dap.configurations.lua = {
    {
        type = "nlua",
        request = "attach",
        name = "Attach to running Neovim instance",
        host = function()
            return "127.0.0.1"
        end,
        port = function()
            local val = 54231
            return val
        end,
    },
}

local dap_ui = require("dapui")

local map = function(lhs, rhs, desc)
    if desc then
        desc = "[DAP] " .. desc
    end

    vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
end

map("<F1>", dap.step_back, "Step Back")
map("<F2>", dap.step_into, "Step Into")
map("<F3>", dap.step_over, "Step Over")
map("<F4>", dap.step_out, "Step Out")
map("<F5>", dap.continue, "Continue")

map("<leader>dr", dap.repl.open)

map("<leader>db", dap.toggle_breakpoint)
map("<leader>dB", function()
    dap.set_breakpoint(vim.fn.input("[DAP] Condition > "))
end)
map("<leader>de", require("dapui").eval)
map("<leader>dE", function()
    require("dapui").eval(vim.fn.input("[DAP] Expression > "))
end)

vim.cmd([[
augroup DapRepl
    au!
    au FileType dap-repl lua require('dap.ext.autocompl').attach()
augroup END
]])

local dap_ui = require("dapui")

---@diagnostic disable: missing-fields
local _ = dap_ui.setup({
    layout = {
        {
            elements = {
                "scopes",
                "breakpoints",
                "stacks",
                "watches",
            },
            size = 40,
            position = "left",
        },
        {
            elements = {
                "repl",
                "console",
            },
            size = 10,
            position = "bottom",
        },
    },
})

local original = {}
local debug_map = function(lhs, rhs, desc)
    local keymaps = vim.api.nvim_get_keymap("n")
    original[lhs] = vim.tbl_filter(function(v)
        return v.lhs == lhs
    end, keymaps)[1] or true

    vim.keymap.set("n", lhs, rhs, { desc = desc })
end

local debug_unmap = function()
    for k, v in pairs(original) do
        if v == true then
            vim.keymap.del("n", k)
        else
            local rhs = v.rhs

            v.lhs = nil
            v.rhs = nil
            v.buffer = nil
            v.mode = nil
            v.sid = nil
            v.lnum = nil

            vim.keymap.set("n", k, rhs, v)
        end
    end

    original = {}
end

dap.listeners.after.event_initialized["dapui_config"] = function()
    dap_ui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
    debug_unmap()
    dap_ui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
    dap_ui.close()
end
