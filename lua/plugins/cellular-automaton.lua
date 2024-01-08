return {
    "eandrju/cellular-automaton.nvim",
    config = function()
        local animations = require('cellular-automaton').animations
        vim.keymap.set("n", "<leader>fml", "<CMD>CellularAutomaton make_it_rain<CR>")
        vim.keymap.set("n", "<leader>tifu", "<CMD>CellularAutomaton scramble<CR>")
    end,
}

