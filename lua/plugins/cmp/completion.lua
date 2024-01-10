---@diagnostic disable: missing-fields
vim.opt.completeopt = { "menu", "menuone", "noselect" }

local ok, lspkind = pcall(require, "lspkind")
if not ok then
    return
end

local cmp = require("cmp")
local luasnip = require("luasnip")

local sources = cmp.config.sources({
    { name = "nvim_lua" },
    { name = "nvim_lsp" },
    { name = "luasnip" },
}, {
    { name = "path" },
    { name = "buffer", keyword_length = 5 },
})

local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local tabFunctionality = function(key,fallback)
    if key == "Tab" then
        if cmp.visible() then
            cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
        elseif has_words_before() then
            cmp.complete()
        else
            fallback()
        end
    elseif key == "STab" then
        if cmp.visible() then
            cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end
end


cmp.setup({
    enabled = function()
        local context = require('cmp.config.context')
        if vim.api.nvim_get_mode().mode == 'c' then
            return true
        else
            return not context.in_treesitter_capture("comment")
                and not context.in_syntax_group("Comment")
        end
    end,
    mapping = {
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-u>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping(cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        })),
        ["<Tab>"] = cmp.mapping(function(fallback) tabFunctionality("Tab", fallback) end, { "i", "s", "c" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback) tabFunctionality("STab", fallback) end, { "i", "s" })
    },
    sources = sources,
    completion = {
        autocomplete = {
            cmp.TriggerEvent.TextChanged,
            cmp.TriggerEvent.InsertEnter,
        },
        completeopt = "menu,menuone,noselect",
    },
    sorting = {
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
            mode = "text",
            maxwidth = function()
                return math.floor(vim.o.columns * 0.45)
            end,
            menu = {
                buffer = "[buf]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[api]",
                cmdline = "[>_]",
                path = "[path]",
                luasnip = "[snip]",
            },
        }),
    },
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "cmdline" }
    }, {
        { name = "path" }
    })
})

local bufIsBig = function(bufnr)
    local max_filesize = 512 * 1024
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
    if ok and stats and stats.size > max_filesize then
        return true
    else
        return false
    end
end

vim.api.nvim_create_autocmd("BufReadPre", {
    callback = function(t)
        local src = sources
        if not bufIsBig(t.buf) then
            src[#src + 1] = { name = 'treesitter', group_index = 2 }
        end

        cmp.setup.buffer {
            sources = src
        }
    end,
})

