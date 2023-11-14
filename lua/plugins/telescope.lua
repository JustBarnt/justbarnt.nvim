return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        priority = 1000,
        config = function()
            require "plugins.config.telescope.setup"
            require "plugins.config.telescope.keys"
        end,
    },
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-hop.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    { 
        'nvim-telescope/telescope-fzf-native.nvim', 
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' 
    },   
    {
        "AckslD/nvim-neoclip.lua",
        config = function()
            require("neoclip").setup()
        end,
    }
}
