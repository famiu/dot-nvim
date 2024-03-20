return {
    { 'echasnovski/mini.align', opts = {} },
    {
        'tpope/vim-surround',
        init = function()
            -- Disable surround mappings to prevent conflict with flash.nvim
            vim.g.surround_no_mappings = 1
        end,
        keys = {
            { 'ds', '<Plug>Dsurround' },
            { 'cs', '<Plug>Csurround' },
            { 'cS', '<Plug>CSurround' },
            { 'ys', '<Plug>Ysurround' },
            { 'yS', '<Plug>YSurround' },
            { 'yss', '<Plug>Yssurround' },
            { 'ySs', '<Plug>YSsurround' },
            { 'ySS', '<Plug>YSsurround' },
            { 'gs', '<Plug>VSurround', mode = 'x' },
            { 'gS', '<Plug>VgSurround', mode = 'x' },
        },
    },
    { 'echasnovski/mini.ai', opts = {} },
    {
        'Wansmer/treesj',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        cmd = { 'TSJSplit', 'TSJJoin' },
        keys = {
            { 'gS', '<CMD>TSJSplit<CR>' },
            { 'gJ', '<CMD>TSJJoin<CR>' },
        },
        opts = {
            use_default_keymaps = false,
        },
    },
    { 'numToStr/Comment.nvim', opts = {} },
}
