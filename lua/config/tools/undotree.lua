vim.api.nvim_set_keymap('n', '<Leader>tu', ':UndotreeToggle<CR>', { noremap = true })

require('whichkey_setup').register_keymap('leader', {
    t = {
        name = '+ui-toggle',
        u = 'UndoTree'
    }
})
