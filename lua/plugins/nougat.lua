return {
    "MunifTanjim/nougat.nvim",
    config = function()
        local Nougat = require("nougat")
        --Core.code is a 1 char code found using :h statusline
        local Core = require("nougat.core")
        local Bar = require("nougat.bar")
        local Item = require("nougat.item")
        local sep = require("nougat.separator")
        local nut = {
            buf = {
                diagnostic_count = require("nougat.nut.buf.diagnostic_count").create,
                filename = require("nougat.nut.buf.filename").create,
                filestatus = require("nougat.nut.buf.filestatus").create,
                filetype = require("nougat.nut.buf.filetype").create,
            },
            git = {
                branch = require("nougat.nut.git.branch").create,
                status = require("nougat.nut.git.status"),
            },
            tab = {
                tablist = {
                    tabs = require("nougat.nut.tab.tablist").create,
                    close = require("nougat.nut.tab.tablist.close").create,
                    icon = require("nougat.nut.tab.tablist.icon").create,
                    label = require("nougat.nut.tab.tablist.label").create,
                    modified = require("nougat.nut.tab.tablist.modified").create,
                },
            },
            mode = require("nougat.nut.mode").create,
            spacer = require("nougat.nut.spacer").create,
            truncation_point = require("nougat.nut.truncation_point").create,
        }

        ---@type nougat.color
        local color = require("nougat.color").get()

        local mode = nut.mode({
            prefix = " ",
            suffix = " ",
            sep_right = sep.right_chevron_solid(true),
        })

        local stl = Bar("statusline")

        -- NOTE: Display NVIM Status
        stl:add_item(mode)

        -- NOTE: Display current branch
        stl:add_item(nut.git.branch({
            hl = { bg = color.magenta, fg = color.bg },
            prefix = "  ",
            suffix = "",
            sep_right = sep.right_chevron_solid(true),
        }))

        -- NOTE: Display Git Status (Added, Changed, Removed)
        stl:add_item(nut.git.status.create({
            hl = { bg = color.bg1 },
            content = {
                nut.git.status.count("added", {
                    hl = { fg = color.green },
                    prefix = " +",
                }),
                nut.git.status.count("changed", {
                    hl = { fg = color.blue },
                    prefix = " ~",
                }),
                nut.git.status.count("removed", {
                    hl = { fg = color.red },
                    prefix = " -",
                }),
            },
            suffix = " ",
            sep_right = sep.right_chevron_solid(true),
        }))

        -- NOTE: Display Filename and current file status
        local filename = stl:add_item(nut.buf.filename({
            hl = { bg = color.bg3 },
            prefix = " ",
            suffix = " ",
        }))

        local filestatus = stl:add_item(nut.buf.filestatus({
            hl = { bg = color.bg3 },
            suffix = " ",
            sep_right = sep.right_chevron_solid(true),
            config = {
                modified = "󰏫",
                nomodifiable = "󰏯",
                readonly = "",
                sep = " ",
            },
        }))
        stl:add_item(nut.spacer())
        stl:add_item(nut.truncation_point())

        -- NOTE: Displaying LSP Errors/Warns/Info/Hints
        stl:add_item(nut.buf.diagnostic_count({
            hidden = false,
            hl = { bg = color.red, fg = color.bg },
            sep_left = sep.left_chevron_solid(true),
            prefix = " ",
            suffix = " ",
            config = {
                severity = vim.diagnostic.severity.ERROR,
            },
        }))
        stl:add_item(nut.buf.diagnostic_count({
            hidden = false,
            hl = { bg = color.yellow, fg = color.bg },
            sep_left = sep.left_chevron_solid(true),
            prefix = " ",
            suffix = " ",
            config = {
                severity = vim.diagnostic.severity.WARN,
            },
        }))
        stl:add_item(nut.buf.diagnostic_count({
            hidden = false,
            hl = { bg = color.blue, fg = color.bg },
            sep_left = sep.left_chevron_solid(true),
            prefix = " ",
            suffix = " ",
            config = {
                severity = vim.diagnostic.severity.INFO,
            },
        }))
        stl:add_item(nut.buf.diagnostic_count({
            hidden = false,
            hl = { bg = color.green, fg = color.bg },
            sep_left = sep.left_chevron_solid(true),
            prefix = " ",
            suffix = " ",
            config = {
                severity = vim.diagnostic.severity.HINT,
            },
        }))

        -- NOTE: Display Filetype information
        stl:add_item(nut.buf.filetype({
            hl = { bg = color.bg1 },
            sep_left = sep.left_chevron_solid(true),
            prefix = " ",
            suffix = " ",
        }))

        stl:add_item(Item({
            hl = { bg = color.bg2, fg = color.blue },
            sep_left = sep.left_chevron_solid(true),
            prefix = "  ",
            content = Core.group({
                Core.code("l"),
                ":",
                Core.code("c"),
            }),
            suffix = " ",
        }))

        stl:add_item(Item({
            hl = { bg = color.blue, fg = color.bg },
            sep_left = sep.left_chevron_solid(true),
            prefix = " ",
            content = Core.code("P"),
            suffix = " ",
        }))

        -- NOTE: Statusline for inactive windows

        local stl_inactive = Bar("statusline")
        stl_inactive:add_item(mode)
        stl_inactive:add_item(filename)
        stl_inactive:add_item(filestatus)
        stl_inactive:add_item(nut.spacer())

        Nougat.set_statusline(function(ctx)
            return ctx.is_focused and stl or stl_inactive
        end)

        local tal = Bar("tabline")

        tal:add_item(nut.tab.tablist.tabs({
            active_tab = {
                hl = { bg = color.bg, fb = color.blue },
                prefix = " ",
                suffix = " ",
                content = {
                    nut.tab.tablist.icon({ suffix = " " }),
                    nut.tab.tablist.label({}),
                    nut.tab.tablist.modified({ prefix = " ", config = { text = "●" } }),
                    nut.tab.tablist.close({ prefix = " ", config = { text = "󰅖" } }),
                },
                sep_right = sep.right_chevron_solid(true),
            },
            inactive_tab = {
                hl = { bg = color.bg2, fg = color.fg2 },
                prefix = " ",
                suffix = " ",
                content = {
                    nut.tab.tablist.icon({ suffix = " " }),
                    nut.tab.tablist.label({}),
                    nut.tab.tablist.modified({ prefix = " ", config = { text = "●" } }),
                    nut.tab.tablist.close({ prefix = " ", config = { text = "󰅖" } }),
                },
                sep_right = sep.right_chevron_solid(true),
            },
        }))

        Nougat.set_tabline(tal)
    end,
}
