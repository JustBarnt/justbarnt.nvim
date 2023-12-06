require("which-key.plugins.presets").operators["v"] = nil
require("which-key.plugins.presets").operators["x"] = nil

require("which-key").register({
    ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
    ["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
    ["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
    ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
    ["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
    ["<leader>h"] = { name = "[H]arpoon", _ = "which_key_ignore" },
    ["<leader>S"] = { ":so %", "[S]ource Init" },
})
