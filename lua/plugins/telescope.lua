return {
    {
        --Works significantly better if `fd` is installed Windows: `choco install fd`
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
        },
        config = function() end,
    },
    "smartpde/telescope-recent-files",
    "nvim-telescope/telescope-ui-select.nvim",
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build =
        "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    },
    {
        "AckslD/nvim-neoclip.lua",
        config = function()
            require("neoclip").setup()
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        priority = 1000,
        config = function()
            if not pcall(require, "telescope") then
                return
            end

            local telescope = require("telescope")
            local t = require("core.telescope_modules")

            telescope.setup({
                defaults = {
                    prompt_prefix = "> ",
                    selection_caret = "> ",
                    entry_prefix = " ",
                    multi_icon = "<>",

                    -- Set Path Display when searching in TelescopePrompt
                    path_display = { "smart" }, --[[ function(opts, path)
                        -- vim.notify(vim.inspect(opts.entry_maker().display()))
                        local tail = require("telescope.utils").path_tail(path)
                        local parentFolder = string.match(path, ".*\\(.+\\.+\\.+\\).-$")

                        if parentFolder then
                            return string.format("%s (..\\%s)", tail, parentFolder)
                        else
                            return string.format("%s (%s)", tail, path)
                        end
                    end, ]]

                    winblend = 0,
                    layout_strategy = "flex", --horizontal, vertical, center, cursor
                    layout_config = {
                        width = 0.95,
                        height = 0.85,
                        prompt_position = "top",

                        horizontal = {
                            preview_width = function(_, cols, _)
                                if cols > 200 then
                                    return math.floor(cols * 0.4)
                                else
                                    return math.floor(cols * 0.6)
                                end
                            end,
                        },

                        vertical = {
                            width = 0.9,
                            height = 0.95,
                            preview_height = 0.5,
                        },

                        flex = {
                            horizontal = {
                                preview_width = 0.9,
                            },
                        },
                    },

                    selection_strategy = "reset",
                    sorting_strategy = "descending",
                    scroll_strategy = "cycle",
                    color_devicons = true,

                    mappings = {
                        i = {
                            ["<RightMouse>"] = t.actions.close,
                            ["<LeftMouse>"] = t.actions.select_default,
                            ["<ScrollWheelDown>"] = t.actions.move_selection_next,
                            ["<ScrollWheelUp>"] = t.actions.move_selection_previous,

                            ["<C-x>"] = false,
                            ["<C-s>"] = t.actions.select_horizontal,
                            ["<C-n>"] = "move_selection_next",

                            ["<C-e>"] = t.actions.results_scrolling_down,
                            ["<C-y>"] = t.actions.results_scrolling_up,

                            -- These are new :)
                            ["<M-p>"] = t.action_layout.toggle_preview,
                            ["<M-m>"] = t.action_layout.toggle_mirror,

                            -- Open in trouble from telescope
                            ["<C-t>"] = t.trouble.open_with_trouble,

                            ["<C-w>"] = function()
                                vim.api.nvim_input("<c-s-w>")
                            end,
                        },

                        n = {
                            ["<C-e>"] = t.actions.results_scrolling_down,
                            ["<C-y>"] = t.actions.results_scrolling_up,
                            ["<C-t>"] = t.trouble.open_with_trouble,
                        },
                    },

                    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
                    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },

                    pickers = {
                        find_files = {
                            find_command = vim.fn.executable("fd") == 1 and { "fd", "--strip-cwd-prefix", "--type", "f" } or nil
                        }
                    },
                },
            })

            -- TODO Figure out why using custom keymap function doesn't work
            vim.keymap.set("n", "<leader>?", t.builtin.oldfiles, { desc = "[?] Find recently opened files" })
            vim.keymap.set("n", "<leader><space>", t.builtin.buffers, { desc = "[ ] Find existing buffers" })
            vim.keymap.set("n", "<leader>/", function()
                -- You can pass additional configuration to telescope to change theme, layout, etc.
                t.builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                    winblend = 3,
                    previewer = false,
                }))
            end, { desc = "[/] Fuzzily search in current buffer" })

            require("core.keymaps").telescope()
            require("telescope").load_extension("file_browser")
            require("telescope").load_extension("ui-select")
        end,
    },
}
