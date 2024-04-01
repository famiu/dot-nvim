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
        'simeji/winresizer',
        keys = { { '<Leader>w', '<CMD>WinResizerStartResize<CR>' } },
        init = function()
            vim.g.winresizer_enable = 1
            vim.g.winresizer_gui_enable = 0
            vim.g.winresizer_finish_with_escape = 1
            vim.g.winresizer_vert_resize = 10
            vim.g.winresizer_horiz_resize = 3
        end,
    },
    {
        'stevearc/oil.nvim',
        opts = {
            -- Make split mappings consistent with Telescope.
            keymaps = {
                ['<C-s>'] = false,
                ['<C-h>'] = false,
                ['<C-v>'] = 'actions.select_vsplit',
                ['<C-x>'] = 'actions.select_split',
            },
        },
        keys = {
            { '<Leader>o', '<CMD>Oil<CR>' },
        },
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
}
