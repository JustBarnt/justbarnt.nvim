local group = vim.api.nvim_create_augroup("LargeFileAutocmds", {})
local old_eventignore = vim.o.eventignore
local large_file_opened = false

vim.api.nvim_create_autocmd({ "BufReadPre" }, {
    group = group,
    callback = function(ev)
        if ev.file then
            local status, size = pcall(function() return vim.loop.fs_stat(ev.file).size end)
            vim.notify(type(ev.file))
            vim.notify('File Size: ' .. size / (1024 * 1024) .. "mb")
            if status and size >= 1024 * 1024 then -- large file
                vim.notify("Large file. Optimizing for preformance")
                vim.wo.wrap = false
                old_eventignore = vim.o.eventignore
                large_file_opened = true
                vim.o.eventignore = "FileType"
                vim.bo.buftype = 'nowrite'
                vim.bo.swapfile = false
                vim.bo.bufhidden = 'unload'
                vim.bo.undolevels = -1

                local is_xml = string.find(ev.file, ".xml")
                if is_xml then
                    vim.o.eventignore = ""
                    vim.bo.buftype = ""
                end
            end
        end
    end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    group = group,
    callback = function(ev)
        if large_file_opened then
            large_file_opened = false
            vim.o.eventignore = nil
        end
    end
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = group,
    callback = function(ev)
        local byte_size = vim.api.nvim_buf_get_offset(ev.buf, vim.api.nvim_buf_line_count(ev.buf))
        if byte_size > 1024 * 1024 then
            if vim.g.loaded_matchparen then
                vim.cmd('NoMatchParen')
            end
        else
            if not vim.g.loaded_matchparen then
                vim.cmd('DoMatchParen')
            end
        end
    end
})

