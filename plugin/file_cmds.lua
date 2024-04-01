vim.api.nvim_create_user_command('Delete', function(opts)
    local bufnr = vim.api.nvim_get_current_buf()
    local bufname = vim.api.nvim_buf_get_name(bufnr)

    if bufname == '' then
        vim.api.nvim_err_writeln('Cannot delete buffer with no name')
    end

    -- Find all buffers with the same name and delete them
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_get_name(buf) == bufname then
            if not pcall(vim.api.nvim_buf_delete, buf, { force = opts.bang }) then
                return
            end
        end
    end

    os.remove(bufname)
end, {
    bang = true,
    desc = 'Delete file and buffer',
})

vim.api.nvim_create_user_command('Rename', function(opts)
    local bufnr = vim.api.nvim_get_current_buf()
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    local dirname = vim.fn.fnamemodify(bufname, ':h')

    if bufname == '' then
        vim.api.nvim_err_writeln('Cannot rename buffer with no name')
    end

    local file_modified = vim.bo[bufnr].modified

    vim.ui.input({ prompt = 'New name: ', default = '', completion = 'file' }, function(new_name)
        local pathsep

        -- If Unix or shellslash is enabled, use forward slash, otherwise use backslash for path separator
        if not require('utilities.os').is_windows() or (vim.fn.exists('+shellslash') and vim.o.shellslash) then
            pathsep = '/'
        else
            pathsep = '\\'
        end

        new_name = dirname .. pathsep .. new_name

        if new_name:sub(-1, -1) == pathsep then
            new_name = new_name .. vim.fn.fnamemodify(bufname, ':t')
        end

        vim.lsp.util.rename(bufname, new_name, {
            overwrite = opts.bang,
            ignoreIfExists = opts.bang,
        })

        -- Restore the modified state of the buffer
        if file_modified then
            vim.cmd.earlier('1f')
            vim.cmd.write()
            vim.cmd.later('1f')
        end
    end)
end, {
    bang = true,
    desc = 'Rename file and buffer',
})
