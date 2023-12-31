if not pcall(require, "telescope") then
    -- TODO Add logging if failed to require telescope
    return
end

local trouble_tele = require("trouble.providers.telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local action_layout = require("telescope.actions.layout")
local putils = require("telescope.previewers.utils")

local set_prompt_to_entry_value = function(prompt_bufnr)
    local entry = action_state.get_selected_entry()
    if not entry or not type(entry) == "table" then
        return
    end

    action_state.get_current_picker(prompt_bufnr):reset_prompt(entry.ordinal)
end

require("telescope").setup({
    defaults = {
        prompt_prefix = "> ",
        selection_caret = "> ",
        entry_prefix = " ",
        multi_icon = "<>",

        --- Displays as filename.ext (../path/to/file) or filename.txt (filename.txt) if file is at the root
        path_display = function(opts, path)
            local tail = require("telescope.utils").path_tail(path)
            local parentFolder = string.match(path, ".*\\(.+\\.+\\.+\\).-$")
            if parentFolder then
                return string.format("%s (..\\%s)", tail, parentFolder)
            else
                return string.format("%s (%s)", tail, path)
            end
        end,

        winblend = 0,

        layout_strategy = "horizontal",
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
                ["<RightMouse>"] = actions.close,
                ["<LeftMouse>"] = actions.select_default,
                ["<ScrollWheelDown>"] = actions.move_selection_next,
                ["<ScrollWheelUp>"] = actions.move_selection_previous,

                ["<C-x>"] = false,
                ["<C-s>"] = actions.select_horizontal,
                ["<C-n>"] = "move_selection_next",

                ["<C-e>"] = actions.results_scrolling_down,
                ["<C-y>"] = actions.results_scrolling_up,

                -- These are new :)
                ["<M-p>"] = action_layout.toggle_preview,
                ["<M-m>"] = action_layout.toggle_mirror,

                -- Open in trouble from telescope
                ["<C-t>"] = trouble_tele.open_with_trouble,

                ["<C-w>"] = function()
                    vim.api.nvim_input("<c-s-w>")
                end,
            },

            n = {
                ["<C-e>"] = actions.results_scrolling_down,
                ["<C-y>"] = actions.results_scrolling_up,
                ["<C-t>"] = trouble_tele.open_with_trouble,
            },
        },

        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

        pickers = {
            find_files = {
                -- I don't like having the cwd prefix in my files
                find_command = vim.fn.executable("fdfind") == 1 and { "fdfind", "--strip-cwd-prefix", "--type", "f" }
                    or nil,

                mappings = {
                    n = {
                        ["kj"] = "close",
                    },
                },
            },

            git_branches = {
                mappings = {
                    i = {
                        ["<C-a>"] = false,
                    },
                },
            },

            buffers = {
                sort_lastused = true,
                sort_mru = true,
            },
        },

        ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
        },
    },
})

-- TODO Figure out why using custom keymap function doesn't work
vim.keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", builtin.buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
    }))
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Search [G]it [F]iles" })
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
