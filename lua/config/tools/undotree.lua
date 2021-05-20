vim.api.nvim_set_keymap('n', '<Leader>tu', ':UndotreeToggle<CR>', { noremap = true })

require('which-key').register({
    t = {
        name = '+ui-toggle',
        u = 'UndoTree'
    }
}, { prefix = "<leader>" })
