return {
    { 'echasnovski/mini.jump', opts = {} },
    { 'echasnovski/mini.jump2d', opts = {} },
    {
        'mfussenegger/nvim-treehopper',
        keys = {
            { 'm', ":<C-U>lua require('tsht').nodes()<CR>", mode = 'o', remap = true },
            { 'm', ":lua require('tsht').nodes()<CR>", mode = 'x' },
        },
    },
}
