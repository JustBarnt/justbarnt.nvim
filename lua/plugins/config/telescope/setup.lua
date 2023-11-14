if not pcall(require, "telescope") then
    -- TODO Add logging if failed to require telescope
    return
end

local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'
local action_layout = require 'telescope.actions.layout'
local putils = require 'telescope.previewers.utils'

local set_prompt_to_entry_value = function(prompt_bufnr)
    local entry = action_state.get_selected_entry()
    if not entry or not type(entry) == "table" then
        return 
    end

    action_state.get_current_picker(prompt_bufnr):reset_prompt(entry.ordinal)
end

require('telescope').setup {
    defaults = {
        prompt_prefix = "> ",
        selection_caret = "> ",
        entry_prefix = " ",
        multi_icon = "<>",

        --path_display = "truncate",
        
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

            }
        },

        file_previewer = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer = require('telescope.previewers').vim.buffer_vimgrep.new,
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
    }
}
