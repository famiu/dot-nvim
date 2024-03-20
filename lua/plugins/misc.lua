local keymap = vim.keymap

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
    { 'mbbill/undotree', keys = { { '<Leader>u', '<CMD>UndotreeToggle<CR>' } } },
    {
        'akinsho/toggleterm.nvim',
        keys = '<C-t>',
        opts = {
            size = 20,
            open_mapping = [[<C-t>]],
        },
    },
    { 'yorickpeterse/nvim-pqf', opts = {} },
    {
        'simeji/winresizer',
        init = function()
            vim.g.winresizer_enable = 1
            vim.g.winresizer_gui_enable = 0
            vim.g.winresizer_finish_with_escape = 1
            vim.g.winresizer_vert_resize = 10
            vim.g.winresizer_horiz_resize = 3
            vim.g.winresizer_start_key = '<Leader>w'
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
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
}
