vim.opt.sessionoptions =
    vim.opt.sessionoptions + 'options' + 'localoptions' + 'resize' + 'winpos' + 'terminal'

require('auto-session').setup {
    auto_session_enabled = false,
    auto_save_enabled = false,
    auto_restore_enabled = false
}

local bind = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

bind('n', '<Leader>ss', '<cmd>SaveSession<CR>', opts)
bind('n', '<Leader>sr', '<cmd>RestoreSession<CR>', opts)
