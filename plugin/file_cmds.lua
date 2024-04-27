vim.api.nvim_create_user_command('Delete', function(opts)
    local bufnr = vim.api.nvim_get_current_buf()
    local bufname = vim.api.nvim_buf_get_name(bufnr)

    if bufname == '' then
        error('Cannot delete buffer with no name')
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

--- Completion for the Rename command. Shows filenames relative to the current buffer's directory.
---
--- @param arg_lead string The leading text of the completion.
--- @param cmdline string The command-line text.
--- @param cursor_pos number The cursor position in the command-line (byte index).
function _G.RenameCmdCompletion(arg_lead, cmdline, cursor_pos)
    local cmdline_until_cursor = string.sub(cmdline, 1, cursor_pos)
    local bufdir = vim.fs.dirname(vim.api.nvim_buf_get_name(0))

    -- Join the buffer directory with the cmdline until the cursor, and then get the directory of that path to get the
    -- directory to complete in.
    --
    -- For example, if the buffer directory is /home/foo/bar/ and the cmdline content before the cursor is 'baz/', then
    -- the completion should look in /home/foo/bar/baz/ for completion items.
    local bufdir_with_cmdline = vim.fs.joinpath(bufdir, cmdline_until_cursor)
    local completion_dir = vim.fs.dirname(bufdir_with_cmdline)

    -- Prefix of the completion, used to match against the basename of the items in the completion directory.
    local prefix = vim.fs.basename(bufdir_with_cmdline)
    -- List of completion items to return.
    local complete_items = {}

    -- Iterate through each item in the completion directory and add it to the completion items liost if it is a
    -- directory that matches the prefix.
    for item, type in vim.fs.dir(completion_dir) do
        -- If the item is a link, get the type of the target of the link.
        if type == 'link' then
            type = vim.uv.fs_stat(vim.fs.joinpath(completion_dir, item)).type
        end

        if type == 'directory' then
            if vim.startswith(item, prefix) then
                -- Make sure the prefix is not repeated in the completion items by taking the substring of the item
                -- starting from the length of the prefix.
                table.insert(complete_items, cmdline_until_cursor .. item:sub(#prefix + 1) .. '/')
            end
        end
    end

    return complete_items
end

vim.api.nvim_create_user_command('Rename', function(opts)
    local bufnr = vim.api.nvim_get_current_buf()
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    local bufdir = vim.fs.dirname(bufname)

    if bufname == '' then
        error('Cannot rename buffer with no name')
    end

    local file_modified = vim.bo[bufnr].modified

    vim.ui.input(
        { prompt = 'New name: ', default = '', completion = 'customlist,v:lua.RenameCmdCompletion' },
        function(new_name)
            if new_name == '' or new_name == nil then
                return
            end

            new_name = vim.fs.joinpath(bufdir, new_name)

            local fs_stat = vim.uv.fs_stat(new_name)
            -- If target is a directory, use the current file name as the new name and move the file into the directory.
            if fs_stat ~= nil and fs_stat.type == 'directory' then
                new_name = vim.fs.joinpath(new_name, vim.fs.basename(bufname))
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
        end
    )
end, {
    bang = true,
    desc = 'Rename file and buffer',
})
