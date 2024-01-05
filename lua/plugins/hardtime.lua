return {
    "m4xshen/hardtime.nvim",
    enabled = false,
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local hardtime = require("hardtime")
        hardtime.setup()
    end,
}
