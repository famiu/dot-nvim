return {
    {
        'mbbill/undotree',
        keys = {
            { '<Leader>u', '<CMD>UndotreeToggle<CR>' },
        },
    },
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
        'folke/todo-comments.nvim',
        opts = {
            highlight = {
                pattern = { [[.*<(KEYWORDS)\s*:]], [[.*<(KEYWORDS)\s*\(\w+\)\s*:]] },
            },
            search = {
                pattern = [[\b(KEYWORDS)\s*(\(\w+\))?\s*:]]
            },
        },
    },
}
