return {
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope-fzf-native.nvim",
        },
        config = function()
            local ok, neogit = pcall(require, "neogit")
            if not ok then
                print("failed to load neogit")
                return
            end

            neogit.setup({
                integrations = {
                    diffview = true,
                },
            })

            vim.keymap.set("n", "<space>vv", ":DiffviewOpen<CR>", { desc = "Diff View Open" })

            vim.keymap.set("n", "<leader>gs", neogit.open, { desc = "[G]it [S]tatus" })
            vim.keymap.set("n", "<leader>gc", function()
                neogit.open({ "commit" })
            end, {
                desc = "[G]it [C]ommit",
            })
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
    "sindrets/diffview.nvim", -- Diff helper
    "Rawnly/gist.nvim", -- GIST HELPER
}
