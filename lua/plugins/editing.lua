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
        'kylechui/nvim-surround',
        keys = {
            'ys',
            'yss',
            'yS',
            'ySS',
            'ds',
            'cs',
            'cS',
            { '<C-g>s', mode = 'i' },
            { '<C-g>S', mode = 'i' },
            { 'gs', mode = 'x' },
            { 'gS', mode = 'x' },
        },
        opts = {
            keymaps = {
                normal = 'ys',
                normal_cur = 'yss',
                normal_line = 'yS',
                normal_cur_line = 'ySS',
                delete = 'ds',
                change = 'cs',
                change_line = 'cS',
                insert = '<C-g>s',
                insert_line = '<C-g>S',
                visual = 'gs',
                visual_line = 'gS',
            },
        },
    },
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
    { 'numToStr/Comment.nvim', opts = {} },
}
