local keymap = vim.keymap

return {
    {
        'EdenEast/nightfox.nvim',
        config = function()
            require('nightfox').setup {}
            vim.cmd.colorscheme('carbonfox')
        end
    },
    {
        'famiu/bufdelete.nvim',
        name = 'bufdelete',
        dev = true,
        init = function()
            keymap.set('n', '<Leader>x', '<CMD>Bdelete<CR>', { silent = true })
        end,
        cmd = { 'Bdelete', 'Bwipeout' }
    },
    { 'numToStr/Comment.nvim', event = 'VeryLazy', opts = {} },
    { 'windwp/nvim-autopairs', event = 'VeryLazy', opts = {} },
    { 'echasnovski/mini.align', event = 'VeryLazy', opts = {} },
    {
        'tpope/vim-surround',
        init = function()
            -- Disable surround mappings to prevent conflict with flash.nvim
            vim.g.surround_no_mappings = 1
        end,
        keys = {
            { 'ds',  '<Plug>Dsurround' },
            { 'cs',  '<Plug>Csurround' },
            { 'cS',  '<Plug>CSurround' },
            { 'ys',  '<Plug>Ysurround' },
            { 'yS',  '<Plug>YSurround' },
            { 'yss', '<Plug>Yssurround' },
            { 'ySs', '<Plug>YSsurround' },
            { 'ySS', '<Plug>YSsurround' },
            { 'gs',  '<Plug>VSurround',  mode = 'x' },
            { 'gS',  '<Plug>VgSurround', mode = 'x' },
        }
    },
    { 'AndrewRadev/splitjoin.vim', keys = { 'gS', 'gJ' } },
    'tpope/vim-sleuth',
    { 'tpope/vim-eunuch', event = 'VeryLazy' },
    { 'mbbill/undotree', keys = {{ '<Leader>u', '<CMD>UndotreeToggle<CR>' }} },
    {
        'akinsho/toggleterm.nvim',
        keys = '<C-t>',
        opts = {
            size = 20,
            open_mapping = [[<C-t>]],
        },
    },
    {
        'rmagatti/auto-session',
        opts = {
            log_level = 'error',
            auto_session_enabled = true,
            auto_session_suppress_dirs = { '~/' },
            auto_session_use_git_branch = true,
            -- the configs below are lua only
            bypass_session_save_file_types = nil,
            session_lens = {
                load_on_setup = false
            },
        },
    },
}
