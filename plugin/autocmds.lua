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

vim.api.nvim_create_autocmd('TermOpen', {
    desc = 'Enter insert mode in Terminal automatically',
    group = augroup,
    callback = function()
        vim.cmd.startinsert()
    end,
})
