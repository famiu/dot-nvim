local augroup = vim.api.nvim_create_augroup('MyConfig', {})

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight on yank',
    group = augroup,
    callback = function() vim.highlight.on_yank() end,
})

-- Automatically create missing directories before save
vim.api.nvim_create_autocmd('BufWritePre', {
    callback = function(opts)
        local path = vim.fs.dirname(vim.api.nvim_buf_get_name(opts.buf))

        if vim.fn.isdirectory(path) == 0 then
            vim.fn.mkdir(path, 'p')
        end
    end,
    desc = 'Mkdir on save',
})
