return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local harpoon = require("harpoon")

        -- REQUIRED
        harpoon:setup({
            settings = {
                save_on_toggle = true,
                sync_on_ui_close = true,
            },
        })

        require 'core.user_commands'.Harpoon()
        local registers = require 'core.whichkey.registers.harpoon'
        require 'which-key'.register(registers.register)
        -- -- Append current open file to our harpon list
        -- vim.keymap.set("n", "<leader>ha", function()
        --     harpoon:list():append()
        --     local file_name = vim.api.nvim_buf_get_name(0)
        --     vim.notify("Added " .. file_name .. " to Harpoon List", vim.log.levels.INFO)
        -- end, { desc = "[H]arpoon [A]dd", silent = true })
        --
        -- -- Toggle a UI popup of or current harpooned items.
        -- vim.keymap.set("n", "<leader>hl", function()
        --     harpoon.ui:toggle_quick_menu(harpoon:list())
        -- end, { desc = "[H]arpoon [L]ist", silent = true })
        --
        -- vim.keymap.set("n", "<leader>hp", function()
        --     harpoon:list():prev()
        -- end, { desc = "[H]arpoon [P]revious" })
        --
        -- vim.keymap.set("n", "<leader>hn", function()
        --     harpoon:list():next()
        -- end, { desc = "[H]arpoon [N]ext" })
        --
        -- for i = 1, 5 do
        --     vim.keymap.set("n", string.format("<leader>%s", i), function()
        --         harpoon:list():select(i)
        --     end, { desc = "Harpoon: Jump To File: [" .. i .. "]", silent = true })
        --     -- Splitting pooned file to the right.
        --     vim.keymap.set("n", string.format("<leader>hs%s", i), function()
        --         vim.notify(
        --             "Opening " .. vim.inspect(harpoon:list():get(i).value .. " in a split buffer."),
        --             vim.log.levels.INFO
        --         )
        --         local buf_name = harpoon:list():get(i).value
        --         vim.cmd.vsplit(buf_name)
        --     end, { desc = "Harpoon: [S]plit File: [" .. i .. "] Right" })
        -- end
    end,
}

