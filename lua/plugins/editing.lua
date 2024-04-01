return {
    {
        'echasnovski/mini.align',
        keys = {
            { 'ga', mode = { 'n', 'x' } },
            { 'gA', mode = { 'n', 'x' } },
        },
        opts = {},
    },
    { 'echasnovski/mini.surround', opts = {} },
    { 'echasnovski/mini.ai', opts = {} },
    {
        'Wansmer/treesj',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        cmd = { 'TSJSplit', 'TSJJoin' },
        keys = {
            { '<Leader>s', function() require('treesj').split() end },
            { '<Leader>j', function() require('treesj').join() end },
        },
        opts = {
            use_default_keymaps = false,
        },
    },
    { 'echasnovski/mini.comment', opts = {} },
}
