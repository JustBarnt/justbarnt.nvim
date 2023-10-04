local status, nvim_comment = pcall(require, "nvim_comment")
if not status then
    print("nvim-comment did not load")
end

-- enable plugin
nvim_comment.setup({
    hook = function()
        require("ts_context_commentstring.internal").update_commentstring()
    end,
})
