-- Tests package to ensure it has loaded, else it will return nil
-- IMO Cleaner alt to declaring serveral status_[package] vars that with an if
-- conditional for each one.
local all_good = function(name)
    local status, pkg = pcall(require, name)

    if not status then
        return { nil }
    end

    return pkg;
end

local cmp = all_good('cmp')
local luasnip = all_good('luasnip')
local lspkind = all_good('lspkind')
local vscode = require("luasnip/loaders/from_vscode").lazy_load()

if cmp == nil or luasnip == nil or lspkind == nil then
    print('One or more packages in nvim-cmp.lua failed to load')
    return
end

cmp.setup({
    snippet = {
        expand = function()
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
        end, { 'i', 's' }),
    },
})
