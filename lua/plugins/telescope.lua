-- Get our keybinds, and opts from a separate module, so we can assign them to keys, and opts in the telescope setup
local tsConfig = require('plugins.config.telescope')
local keys = tsConfig.keys
local opts = tsConfig.opts

return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build  = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
            },
            {
                "debugloop/telescope-undo.nvim",
                keys = {
                    {
                        "<leader>U",
                        "<cmd>Telescope undo<cr>",
                        desc = "Fuzzy Search File History"
                    }
                },
            },
          "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        keys  = vim.tbl_extend("force", keys, {}),
        opts = vim.tbl_extend("force", opts, {}),
    }
}
