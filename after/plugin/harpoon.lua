local status, harpoon = pcall(require, "harpoon")

if not status then
    return
end


harpoon.setup {}

--TODO Remove after getting used to leader>hm/leader>hl
vim.keymap.set("n", "<leader>ha", function()
    require("harpoon.mark").add_file()
    vim.notify("Use <leader>hm", "warn")
end, { desc = "[A]dd File" })


vim.keymap.set("n", "<leader>ht",
    function()
        require("harpoon.ui").toggle_quick_menu()
        vim.notify("Use <leader>hl>", "warn")
    end, { desc = "[T]oggle UI" })

vim.keymap.set("n", "<leader>hm", function() require("harpoon.mark").add_file() end, { desc = "[A]dd File" })
vim.keymap.set("n", "<leader>hl", function() require("harpoon.ui").toggle_quick_menu() end, { desc = "[T]oggle UI" })


for i = 1, 5 do
    vim.keymap.set(
        "n",
        string.format("<space>%s", i),
        function()
            require("harpoon.ui").nav_file(i)
        end,
        {
            desc = "Harpoon: Jump To File: " .. i
        }
    )
end

