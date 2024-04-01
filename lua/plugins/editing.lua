return {
    {
        'echasnovski/mini.align',
        keys = {
            { 'ga', mode = { 'n', 'x' } },
            { 'gA', mode = { 'n', 'x' } },
        },
        opts = {},
    },
    {
        'echasnovski/mini.surround',
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
    { 'echasnovski/mini.ai', opts = {} },
    {
        'Wansmer/treesj',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        cmd = { 'TSJSplit', 'TSJJoin' },
        keys = {
            { 'gS', function() require('treesj').split() end },
            { 'gJ', function() require('treesj').join() end },
        },
        opts = {
            use_default_keymaps = false,
        },
    },
    { 'echasnovski/mini.comment', opts = {} },
    {
        'echasnovski/mini.trailspace',
        lazy = false,
        opts = {},
        keys = {
            {
                '<Leader>T',
                function()
                    require('mini.trailspace').trim()
                    require('mini.trailspace').trim_last_lines()
                end,
            },
        },
    },
}
