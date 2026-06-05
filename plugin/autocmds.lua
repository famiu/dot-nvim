local augroup = vim.api.nvim_create_augroup('MyConfig', {})

vim.api.nvim_create_autocmd({ 'TextYankPost', 'TextPutPost' }, {
    desc = 'Highlight on yank',
    group = augroup,
    callback = function(_)
        vim.hl.hl_op({ higroup = 'Visual', timeout = 300 })
    end,
})

vim.api.nvim_create_autocmd('TermOpen', {
    desc = 'Enter insert mode in Terminal automatically',
    group = augroup,
    callback = function()
        vim.cmd.startinsert()
    end,
})
