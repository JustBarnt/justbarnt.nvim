local M = {}

-- Set keymap for visual mode
-- @param args table: The arguments table
--  - args[1] string: Mode to apply keybind in: Defaults to 'n'
--  - args[2] string: Key sequence
--  - args[3] function|string: Function or string command to run
--  - args[4] table: 
--      - desc string: Description of the keybind: Defaults to ""
--      - silent boolean: Whether or not to suppress the display of the command being executed in the command line: Defaults to true
--      - buffer number: The buffer as a number, passing 0 or nothing will apply the bind to all buffers (to apply the bind to): Defaults to 0  

M.remap = function(args)
    if #args < 3 or type(args[1]) ~= "string" or type(args[2]) ~= "string" or (type(args[3]) ~= "function" and type(args[3]) ~= "string") then
        error("Invalid arguments. Expected at least three arguments: mode, key, func")
    end

    local desc = (args[4] and args[4].desc) or ""
    local silent = (args[4] and args[4].silent) or true
    local buffer = (args[4] and args[4].buffer) or 0

    vim.keymap.set(args[1], args[2], args[3], { desc = desc, silent = silent, buffer = buffer })
end


return M
