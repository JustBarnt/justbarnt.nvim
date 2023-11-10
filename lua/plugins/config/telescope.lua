local M = {}
local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local themes = require('telescope.themes')

M.keys = {
    {
        "<leader>fp",
        builtin.find_files({
            cwd = require('lazy.core.config').options.root
        }),
        desc = "File Plugin Files",
    },
    {
        "<leader>/",
        builtin.current_buffer_fuzzy_find(themes.get_dropdown {
            winblend = 10,
            previewer = false,
        }),
        desc = "[/] Fuzzily search in current bufffer"
    },
    { "<leader>?", builtin.oldfiles, desc = "[?] Find recently opened files" },
    { "<leader><space>", builtin.buffers, desc = "[ ] Find existing buffers" },
    { "<leader>gf", builtin.git_files, desc = "Search [G]it [F]iles" },
    { "<leader>sf", builtin.find_files, desc = "[S]earch [F]iles" },
    { "<leader>sh", builtin.help_tags, desc = "[S]earch [H]elp" },
    { "<leader>sw", builtin.grep_string, desc = "[S]earch current [W]ord" },
    { "<leader>sg", builtin.live_grep, desc = "[S]earch by [Grep]" },
    { "<leader>sd", builtin.diagnostics, desc = "[S]earch [D]iagnostics" },
    { "<leader>sr", builtin.resume, desc = "[S]earch [R]esume" }
}
    nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

M.opts = {
    defaults = {
        --[[file_ignore_patterns = "node_modules",
        preview = {
            treesitter = false, -- Disable treesitter in preview so large files to hang
            filesize_limit = 0.1,
            timeout = 250,
        },]]
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.5,
            },
            width = 0.8,
            height = 0.8,
            preview_cutoff = 120,
        },
        sorting_strategy = "ascending",
        winblend = 0
    },
    pickers = {
        buffers = {
            mappings = {
                n = {
                    ["d"] = actions.delete_buffer,
                }
            }
        }
    }
}

-- load fzf for faster searching
 telescope.load_extension("fzf")
 telescope.load_extension("harpoon")

return M
