-- TODO: Setup with current used bindings

local M = {}

M.defaults = {
    ["c"] = { name = "[C]ode", _ = "which_key_ignore" },
    ["d"] = { name = "[D]ocument", _ = "which_key_ignore" },
    ["r"] = { name = "[R]ename", _ = "which_key_ignore" },
    ["s"] = { name = "[S]earch", _ = "which_key_ignore" },
    ["w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
    ["h"] = { name = "[H]arpoon", _ = "which_key_ignore" },
    ["t"] = { name = "[T]rouble", _ = "which_key_ignore" },
}

M.non_leader = {}

return M
