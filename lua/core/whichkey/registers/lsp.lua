local M = {}

local Detour = require('detour').Detour

-- TODO: Setup user commands for current function calls to clean up register
M.leader = {
    ["<leader>c"] = {
        name = "Code",
        a = {
            function()
                vim.lsp.buf.code_action({})
            end,
            "Code Actions"
        },
        r = {
            function()
                vim.lsp.buf.rename()
            end,
            "Rename Symbol"
        },
    },
    ["<leader>l"] = {
        name = "LSP",
        f = { "<CMD>LspFormat<CR>", "LSP Format" },
        r = { "<CMD>LspRestart<CR>", "LSP Restart" },
        i = { "<CMD>LspInfo<CR>", "LSP Info" },
        s = { "<CMD>LspStart<CR>", "LSP Start" },
        k = { "<CMD>LspStop<CR>", "LSP Stop" }
    },
    g = {
        name = "Go-To LSP",
        d = {
            function()
                vim.lsp.buf.definition({ reuse_win = false })
                Detour()
            end,
            "Go-To Definition"
        },
        D = {
            function()
                vim.lsp.buf.declaration({ reuse_win = false })
                Detour()
            end,
            "Go-To Declaration"
        },
        I = {
            function()
                vim.lsp.buf.implementation({ reuse_win = false })
                Detour()
            end,
            "Go-To Implementation"
        },
        T = {
            function()
                vim.lsp.buf.type_definition({ reuse_win = false })
                Detour()
            end,
            "Go-To Type Definition"
        }
    },
    K = {
        function()
            vim.lsp.buf.hover()
        end,
        "Definition Hover"
    }
}

return M
