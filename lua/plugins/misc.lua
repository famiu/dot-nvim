return {
    {
        'mason-org/mason.nvim',
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
        keys = { { '-', '<CMD>Oil<CR>' } },
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    'tpope/vim-eunuch',
}
