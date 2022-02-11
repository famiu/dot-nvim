-- Set colorscheme
vim.cmd('colorscheme codedark')

-- Set background color
vim.opt.background = 'dark'

-- Load UI modules
require('config.ui.feline')
require('config.ui.gitsigns')
require('config.ui.nvim-tree')
