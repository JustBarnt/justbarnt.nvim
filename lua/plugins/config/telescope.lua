local tStatus, telescope = pcall(require, "telescope")
if not tStatus then
    print("telescope did not load")
    return
end

local bStatus, builtin = pcall(require, "telescope.builtin")
if not bStatus then
    print("telescope builtins did not load")
    return
end

local tStatus, themes = pcall(require, "telescope.themes")
if not tStatus then
    print("telescope builtins did not load")
    return
end

local aStatus, actions = pcall(require, "telescope.actions")
if not aStatus then
    print("telescope actions did not load")
    return
end

telescope.setup({
    defaults = {
        file_ignore_patterns = { "node_modules" },
        path_display = { "truncate" },
        preview = {
            treesitter = false, -- Disable treesitter in preivew window so large files don't hang
            filesize_limit = 0.1,
            timeout = 250,
        },
    },
    pickers = {
        buffers = {
            mappings = {
                n = {
                    ["d"] = actions.delete_buffer,
                },
            },
        },
    },
})

vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    builtin.current_buffer_fuzzy_find(themes.get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })



-- load fzf for faster searching
telescope.load_extension("fzf")
telescope.load_extension("harpoon")
