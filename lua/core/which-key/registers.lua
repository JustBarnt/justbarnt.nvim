-- TODO: Setup with current used bindings

local M = {}

M.defaults = {
    ["c"] = { name = "[C]ode", },
    ["d"] = { name = "[D]ocument", },
    ["r"] = { name = "[R]ename", },
    ["s"] = { name = "[S]earch", },
    ["w"] = { name = "[W]orkspace", },
    ["h"] = { name = "[H]arpoon", },
    ["t"] = { name = "[T]rouble", },
}

M.non_leader = {}

return M
