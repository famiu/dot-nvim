return {
    {
        'echasnovski/mini.jump',
        opts = {},
        keys = {
            { 'f', mode = { 'n', 'x' } },
            { 'F', mode = { 'n', 'x' } },
            { 'f', mode = { 'n', 'x' } },
            { 'T', mode = { 'n', 'x' } },
        }
    },
    {
        'echasnovski/mini.jump2d',
        opts = {},
        keys = { { '<CR>', mode = {'n', 'x' } } },
    },
    {
        'mfussenegger/nvim-treehopper',
        keys = {
            { 'm', ":<C-U>lua require('tsht').nodes()<CR>", mode = 'o', remap = true },
            { 'm', ":lua require('tsht').nodes()<CR>", mode = 'x' },
        },
    },
}
