return {
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup {
                -- LHS of operator-pending mapping in NORMAL + VISUAL mode
                opleader = {
                    line = "gc",
                    block = "gb",
                },

                -- Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
                mappings = {
                    
                    -- operator-pending mapping
                    -- Includes:
                    --  `gcc`               -> line-comment  the current line
                    --  `gcb`               -> block-comment the current line
                    --  `gc[count]{motion}` -> line-comment  the region contained in {motion}
                    --  `gb[count]{motion}` -> block-comment the region contained in {motion}
                    basic = true,
                    
                    -- Extra mappings
                    -- `gco`                -> Add comment on line above
                    -- `gcO`                -> Add comment on line below
                    -- `gcA`                -> Add comment at end of line
                    extra = true,
                },
    
                -- LHS of toggle mapping in NORMAL + VISUAL mode
                toggler = {
                    -- line-comment keymap
                    -- Makes sense to be related to your opleader.line
                    line = "gcc",

                    -- block-comment keymap
                    -- Same as above
                    block = "gbc",
                }
            }

            local comment_ft = require 'Comment.ft'
            -- TODO: May want to set this for other languages, js, ts, etc.
            comment_ft.set("lua", { "--%", "--[[%s]]" })
        end,
    },
}
