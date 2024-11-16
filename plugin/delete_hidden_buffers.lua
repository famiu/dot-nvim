--- Command to delete hidden buffers that are not attached to any window.
vim.api.nvim_create_user_command('DeleteHiddenBuffers', function()
    --- @type table<number, boolean>
    local buffers_with_windows = {}

    for _, tp in ipairs(vim.api.nvim_list_tabpages()) do
        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tp)) do
            buffers_with_windows[vim.api.nvim_win_get_buf(win)] = true
        end
    end

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if not buffers_with_windows[buf] and vim.api.nvim_buf_is_loaded(buf) and not vim.bo[buf].modified then
            vim.api.nvim_buf_delete(buf, { force = true })
        end
    end
end, { nargs = 0 })
