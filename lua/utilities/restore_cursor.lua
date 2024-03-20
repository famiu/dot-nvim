local fn = vim.fn

local no_restore_cursor_buftypes = {
    'quickfix',
    'nofile',
    'help',
    'terminal',
}

local no_restore_cursor_filetypes = {
    'gitcommit',
    'gitrebase',
}

local function restore_cursor()
    if
        fn.line([['"]]) >= 1
        and fn.line([['"]]) <= fn.line('$')
        and not vim.tbl_contains(no_restore_cursor_buftypes, vim.o.buftype)
        and not vim.tbl_contains(no_restore_cursor_filetypes, vim.o.filetype)
    then
        vim.cmd('normal! g`" | zv')
    end
end

-- Remember last location in file
vim.api.nvim_create_autocmd('BufReadPost', { callback = restore_cursor, desc = 'Restore cursor' })
