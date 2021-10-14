vim.opt.sessionoptions = vim.opt.sessionoptions + 'resize' + 'winpos' + 'terminal'

require('auto-session').setup ()

local bind = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

bind('n', '<Leader>ss', '<cmd>SaveSession<CR>', opts)
bind('n', '<Leader>sr', '<cmd>RestoreSession<CR>', opts)
