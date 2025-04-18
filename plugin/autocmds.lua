local augroup = vim.api.nvim_create_augroup('MyConfig', {})

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight on yank',
    group = augroup,
    callback = function(opts)
        vim.hl.on_yank({
            event = opts.data or vim.v.event,
        })
    end,
})

-- Automatically create missing directories before save
vim.api.nvim_create_autocmd('BufWritePre', {
    callback = function(args)
        local path = vim.fs.dirname(vim.api.nvim_buf_get_name(args.buf))

        if vim.fn.isdirectory(path) == 0 then
            vim.fn.mkdir(path, 'p')
        end
    end,
    desc = 'Mkdir on save',
})
