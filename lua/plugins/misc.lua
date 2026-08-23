require('mason').setup({
    PATH = 'append',
    max_concurrent_installers = require('utilities.os').pu_count(),
})

require('oil').setup({
    -- Make split mappings consistent with Telescope.
    keymaps = {
        ['<C-s>'] = false,
        ['<C-h>'] = false,
        ['<C-v>'] = 'actions.select_vsplit',
        ['<C-x>'] = 'actions.select_split',
    },
})

vim.keymap.set('n', '-', '<CMD>Oil<CR>')
