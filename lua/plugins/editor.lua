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
        end
    },
    { 'numToStr/Comment.nvim', opts = {} },
    { 'windwp/nvim-autopairs', opts = {} },
    { 'echasnovski/mini.align', opts = {} },
    {
        'tpope/vim-surround',
        init = function()
            -- Change surround mappings so that they don't conflict with leap.nvim.
            vim.g.surround_no_mappings = 1
            keymap.set('n', 'ds', '<Plug>Dsurround')
            keymap.set('n', 'cs', '<Plug>Csurround')
            keymap.set('n', 'cS', '<Plug>CSurround')
            keymap.set('n', 'ys', '<Plug>Ysurround')
            keymap.set('n', 'yS', '<Plug>YSurround')
            keymap.set('n', 'yss', '<Plug>Yssurround')
            keymap.set('n', 'ySs', '<Plug>YSsurround')
            keymap.set('n', 'ySS', '<Plug>YSsurround')
            keymap.set('x', 'gs', '<Plug>VSurround')
            keymap.set('x', 'gS', '<Plug>VgSurround')
        end
    },
    'AndrewRadev/splitjoin.vim',
    'tpope/vim-sleuth',
    { 'mbbill/undotree', keys = {{ '<Leader>u', '<CMD>UndotreeToggle<CR>' }} },
    {
        'akinsho/toggleterm.nvim',
        lazy = true,
        keys = '<C-t>',
        opts = {
            size = 20,
            open_mapping = [[<C-t>]]
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
            bypass_session_save_file_types = nil
        }
    },
}
