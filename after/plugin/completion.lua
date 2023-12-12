---@diagnostic disable: missing-fields
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Dont show "dumb matching stuff" https://github.com/tjdevries/confing_manager/blob/master/xdg_config/nvim/after/plugin/completion.lua#L5C39-L5C39
vim.opt.shortmess:append("c")

local ok, lspkind = pcall(require, "lspkind")
if not ok then
    return
end

lspkind.init({
    symbol_map = {
        Copilot = "",
    },
})
vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

local cmp = require("cmp")

cmp.setup({
    mapping = {
        ["<C-d>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-u>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.scroll_docs(-4),
        ["<C-n>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping(
            cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
            }),
            { "i", "c" }
        ),
        ["<M-y>"] = cmp.mapping(
            cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
            }),
            { "i", "c" }
        ),

        ["<c-space>"] = cmp.mapping({
            i = cmp.mapping.complete(),
            c = function(
                _ --[[fallback]]
            )
                if cmp.visible() then
                    if not cmp.confirm({ select = true }) then
                        return
                    end
                else
                    cmp.complete()
                end
            end,
        }),

        -- ["<tab>"] = false,
        ["<tab>"] = cmp.config.disable,

        -- ["<tab>"] = cmp.mapping {
        --   i = cmp.config.disable,
        --   c = function(fallback)
        --     fallback()
        --   end,
        -- },

        -- Testing
        ["<c-q>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        }),
    },
    sources = cmp.config.sources({
        { name = "nvim_lua" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "copilot" },
        { name = "eruby" },
    }, {
        { name = "path" },
        { name = "buffer", keyword_length = 5 },
    }, {
        { name = "gh_issues" },
    }),

    sorting = {
        -- TODO: Would be cool to add stuff like "See variable names before method names" in rust, or something like that.
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,

            -- copied from cmp-under, but I don't think I need the plugin for this.
            -- I might add some more of my own.
            function(entry1, entry2)
                local _, entry1_under = entry1.completion_item.label:find("^_+")
                local _, entry2_under = entry2.completion_item.label:find("^_+")
                entry1_under = entry1_under or 0
                entry2_under = entry2_under or 0
                if entry1_under > entry2_under then
                    return false
                elseif entry1_under < entry2_under then
                    return true
                end
            end,

            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },

    -- Youtube: mention that you need a separate snippets plugin
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },

    formatting = {
        -- Youtube: How to set up nice formatting for your sources.
        format = lspkind.cmp_format({
            with_text = true,
            menu = {
                buffer = "[buf]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[api]",
                path = "[path]",
                luasnip = "[snip]",
                gh_issues = "[issues]",
                tn = "[TabNine]",
                eruby = "[erb]",
                cody = "[cody]",
            },
        }),
    },

    experimental = {
        -- I like the new menu better! Nice work hrsh7th
        native_menu = false,

        -- Let's play with this for a day or two
        ghost_text = false,
    },
})

_ = vim.cmd([[
    augroup DadbodSql
        au!
        autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer { sources = { { name = "vim-dadbod-completion" } } }
    augroup END
]])
