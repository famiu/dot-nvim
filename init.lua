-- Get number of processing units to use for configuring concurrent stuff
PU_COUNT = tonumber(vim.fn.system({ 'nproc' }))

-- Basic option configurations and similar settings
require('settings')

-- Basic keybinds
require('keybinds')

-- Boostrap lazy.nvim if needed
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

-- Load plugins
require('lazy').setup({ import = 'plugins' }, {
    dev = {
        path = '~/Workspace/neovim'
    },
    concurrency = PU_COUNT,
})

-- LSP
require('lsp')

-- Other utilities
require('utilities')
