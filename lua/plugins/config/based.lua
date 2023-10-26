local status, based = pcall(require, "based")

if not status then
    vim.print("Based failed to load.")
    return
end

based.setup({
    highlight = "MyHighlightGroup"
})

local nmap = function(keys, func, desc)
    if desc then
        desc = "Based: " .. desc
    end

    vim.keymap.set({ "n", "v" }, keys, func, { desc = desc })
end

nmap('<C-b>', function() based.convert() end, "Base Convert")
nmap("<leader>Bh", function() based.convert("hex")end, "Convert [B]ase to [h]ex")
nmap("<leader>Bd", function() based.convert("dec") end, "Convert [B]ase to [d]ec")

