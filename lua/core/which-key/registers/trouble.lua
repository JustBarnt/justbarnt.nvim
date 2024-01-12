local M = {}

M.register = {
    ["<leader>t"] = {
        name = "Trouble",
        t = { "<CMD>TroubleToggle<CR>", "Trouble Toggle" },
        w = { "<CMD>Troubl workspace_diagnostics<CR>", "Trouble Workspace Diagnostics" },
        d = { "<CMD>Trouble document_diagnostics<CR>", "Trouble Document Diagnostics" },
        q = { "<CMD>Trouble quickfix<CR>", "Trouble Quickfix List" },
        l = { "<CMD>Trouble loclist<CR>", "Trouble Local List" },
        x = { "<CMD>TroubleClose<CR>", "Trouble Close" },
    }
}

return M
