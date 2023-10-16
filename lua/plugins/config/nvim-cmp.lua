require 'utils'
local status, cmp = pcall(require, 'cmp')

if not status then
    Log('cmp failed to load')
    return
end


local cmp_action = require('lsp-zero').cmp_action()
cmp.setup({
    preselect = 'item',
    completion = {
        completeopt = "menu,menuone,noinsert",
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
    },
    mapping = {
        -- Move up and down completion menu
        ['<C-d>'] = cmp.mapping.select_next_item({behavior = 'select'}),
        ['<C-u>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
        -- Jump through available items 4 at a time
        ['<C-p>'] = cmp.mapping.scroll_docs(-4),
        ['<C-n>'] = cmp.mapping.scroll_docs(4),
        -- Insert currently selected item\
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        -- Enables tabbing through items, if in the middle of a word it will autocomplete it
        ['<Tab>'] = cmp_action.tab_complete(),
        ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
        -- Invoke Autocomplete menu manuall
        ['<C-Space>'] = cmp.mapping.complete(),
    },
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
})
