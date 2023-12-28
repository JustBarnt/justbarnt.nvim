-- Enables highlighting an actions for comments TODO,FIX,NOTE etc.
return {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
        local todo = require("todo-comments")

        ---@class TodoOptions
        local opts = {
            keywords = {
                FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
                TODO = { icon = " ", color = "info" },
                HACK = { icon = " ", color = "warning" },
                WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
                PERF = { icon = "󰀘", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                NOTE = { icon = "", color = "hint", alt = { "INFO" } },
                TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
            },
        }

        todo.setup(opts)

        vim.keymap.set("n", "<leader>tc", function()
            vim.cmd([[TodoTrouble<cr>]])
        end, { desc = "[T]odo [T]rouble", silent = true })

        vim.keymap.set("n", "<leader>tC", function()
            vim.cmd([[TodoTrouble keywords=TODO,FIX,FIXME<cr><cr>]])
        end, { desc = "[T]odo: Show FIX, TODO, FIXME", silent = true })

        vim.keymap.set("n", "<leader>st", ":TodoTelescope<CR>", { desc = "[S]earch [T]odos", silent = true })

        vim.keymap.set("n", "<leader>sT", function()
            vim.cmd([[TodoTelescope keywords=TODO,FIX,FIXME<cr>]])
        end, { desc = "[S]earch [T]odo Keywords: TODO, FIX, FIXME", silent = true })
    end,
}
