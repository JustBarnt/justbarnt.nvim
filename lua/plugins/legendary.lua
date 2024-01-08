return {
    "mrjones2014/legendary.nvim",
    priority = 10000,
    version = "v2.13.6",
    lazy = false,
    -- potentially installing stevearc/dressing.nvim
    -- sqlite is only needed if I want to use frecency sorting
    -- dependencies = { 'kkharji/sqlite.lua' }
    config = function()
        require('legendary').setup({
            extensions = {
                lazy_nvim = true,
                which_key = {
                    auto_register = false -- TODO: Will have to pass the register tables when I create them
                }
            },
        })
    end,
}

