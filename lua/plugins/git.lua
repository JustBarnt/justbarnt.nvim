return {
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "nvim-telescope/telescope-fzf-native.nvim",
        },
        config = function()
            local ok, neogit = pcall(require, "neogit")
            if not ok then
                print("failed to load neogit")
                return
            end
            local diffview = require("diffview")
            neogit.setup({
                integrations = {
                    diffview = true,
                },
            })

            vim.keymap.set("n", "<leader>dv", function()
                -- Disable error cause open accepts no argurments to diff whole repo
                ---@diagnostic disable-next-line
                diffview.open()
            end, { desc = "Diff View Open" })

            vim.keymap.set("n", "<leader>gs", function()
                neogit.open({ kind = "auto" })
            end, { desc = "[G]it [S]tatus" })

            vim.keymap.set("n", "<leader>gc", function()
                neogit.open({ "commit", kind = "auto" })
            end, {
                desc = "[G]it [C]ommit",
            })
        end,
    },
    {
        "sindrets/diffview.nvim",
        config = function()
            local actions = require("diffview.actions")
            local diffview = require("diffview")
            diffview.setup({})
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            local gs_ok, gitsigns = pcall(require, "gitsigns")

            if not gs_ok then
                print("failed to load gitsigns")
                return
            end

            gitsigns.setup({
                signs = {
                    add = { text = "│" },
                    change = { text = "│" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                    untracked = { text = "┆" },
                },
            })
        end,
    },
    "rhysd/committia.vim", -- Commit msgs
}
