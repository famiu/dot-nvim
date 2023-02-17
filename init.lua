-- Get number of processing units to use for configuring concurrent stuff
PU_COUNT = tonumber(vim.fn.system({ 'nproc' }))

-- Basic option configurations and similar settings
require('settings')

-- Basic keybinds
require('keybinds')

-- Plugins
require('plugins')

-- LSP
require('lsp')

-- Other utilities
require('utilities')
