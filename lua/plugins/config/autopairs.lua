local autopairs_status, autopairs = pcall(require, "nvim-autopairs")

if not autopairs_status then
    print("nvim-autopairs did not load")
end

autopairs.setup({
    check_ts = true, -- enabling treesitting (NOT Typescript)
    ts_config = {
        lua = { "string" },
        javascript = { "template_string" },
        java = false
    },
})

local cmp_autopairs_status, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
if not cmp_autopairs_status then 
    print("cmp-autopairs did not load")
    return
end

local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
    print("cmp did not load")
    return
end

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
