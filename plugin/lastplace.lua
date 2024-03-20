local no_lastplace_buftypes = {
    'quickfix',
    'nofile',
    'help',
    'terminal',
}

local no_lastplace_filetypes = {
    'gitcommit',
    'gitrebase',
}

-- Remember last location in file
vim.api.nvim_create_autocmd('BufReadPost', {
    callback = function()
        if
            vim.fn.line([['"]]) >= 1
            and vim.fn.line([['"]]) <= vim.fn.line('$')
            and not vim.tbl_contains(no_lastplace_buftypes, vim.o.buftype)
            and not vim.tbl_contains(no_lastplace_filetypes, vim.o.filetype)
        then
            vim.cmd('normal! g`" | zv')
        end
    end,
    desc = 'Remember last place in files',
})
