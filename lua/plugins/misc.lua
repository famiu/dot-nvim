return {
    {
        'famiu/bufdelete.nvim',
        name = 'bufdelete',
        dev = true,
        keys = {
            { '<Leader>x', '<CMD>Bdelete<CR>' },
            { '<Leader>X', '<CMD>Bwipeout<CR>' },
        },
        cmd = { 'Bdelete', 'Bwipeout' },
    },
    {
        'williamboman/mason.nvim',
        opts = {
            PATH = 'append',
            max_concurrent_installers = require('utilities.os').pu_count(),
        },
    },
    {
        'stevearc/oil.nvim',
        lazy = false,
        opts = {
            -- Make split mappings consistent with Telescope.
            keymaps = {
                ['<C-s>'] = false,
                ['<C-h>'] = false,
                ['<C-v>'] = 'actions.select_vsplit',
                ['<C-x>'] = 'actions.select_split',
            },
        },
        keys = { { '<Leader>o', '<CMD>Oil<CR>' } },
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    'tpope/vim-eunuch',
}
