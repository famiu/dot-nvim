return {
    {
        'nvim-mini/mini.align',
        keys = {
            { 'ga', mode = { 'n', 'x' } },
            { 'gA', mode = { 'n', 'x' } },
        },
        opts = {},
    },
    { 'nvim-mini/mini.ai', opts = {} },
    {
        'nvim-mini/mini.surround',
        keys = {
            { 'sa', mode = { 'n', 'x' } },
            'sd',
            'sr',
            'sf',
            'sF',
            'sh',
            'sn',
        },
        opts = {},
    },
    {
        'Wansmer/treesj',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        cmd = { 'TSJSplit', 'TSJJoin' },
        keys = {
            {
                'gS',
                function()
                    require('treesj').split()
                end,
            },
            {
                'gJ',
                function()
                    require('treesj').join()
                end,
            },
        },
        opts = {
            use_default_keymaps = false,
        },
    },
    'lewis6991/spaceless.nvim',
}
