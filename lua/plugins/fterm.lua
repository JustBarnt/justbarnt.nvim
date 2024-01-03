return {
    "numToStr/FTerm.nvim",
    config = function()
        local fterm = require("FTerm")
        ---@class Config
        local cfg = {
            border = "rounded",
            cmd = "pwsh.exe",
        }

        fterm.setup(cfg)
        require("core.user_commands").FTerm()
        require("core.keymaps").FTerm()
    end,
}
