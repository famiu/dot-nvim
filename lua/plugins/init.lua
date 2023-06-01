return {
    {
        'EdenEast/nightfox.nvim',
        config = function()
            require('nightfox').setup({})
            vim.cmd.colorscheme('carbonfox')
        end
    },
    {
        'williamboman/mason.nvim',
        opts = {
            PATH = 'append',
            pip = { upgrade_pip = true },
            max_concurrent_installers = PU_COUNT,
            ensure_installed = {
                'pyright',
                'lua-language-server',
                'vim-language-server',
                'bash-language-server',
                'cmake-language-server',
                'json-lsp',
                'debugpy'
            }
        },
    },
    { 'folke/neodev.nvim', lazy = true,  opts = { lspconfig = false } },
    { 'ggandor/leap.nvim', config = function() require('leap').add_default_mappings(true) end },
    {
        'famiu/bufdelete.nvim',
        lazy = true,
        name = 'bufdelete',
        dev = true,
        cmd = { 'Bdelete', 'Bwipeout' },
        keys = {
            { '<Leader>x', '<CMD>Bdelete<CR>', desc = 'Delete buffer' }
        }
    },
    { 'numToStr/Comment.nvim', config = true },
    { 'windwp/nvim-autopairs', config = true },
    { 'echasnovski/mini.align', config = function() require('mini.align').setup() end },
    {
        'tpope/vim-surround',
        init = function ()
            -- Change surround mappings so that they don't conflict with leap.nvim.
            vim.g.surround_no_mappings = 1
            vim.keymap.set('n', 'ds', '<Plug>Dsurround')
            vim.keymap.set('n', 'cs', '<Plug>Csurround')
            vim.keymap.set('n', 'cS', '<Plug>CSurround')
            vim.keymap.set('n', 'ys', '<Plug>Ysurround')
            vim.keymap.set('n', 'yS', '<Plug>YSurround')
            vim.keymap.set('n', 'yss', '<Plug>Yssurround')
            vim.keymap.set('n', 'ySs', '<Plug>YSsurround')
            vim.keymap.set('n', 'ySS', '<Plug>YSsurround')
            vim.keymap.set('x', 'gs', '<Plug>VSurround')
            vim.keymap.set('x', 'gS', '<Plug>VgSurround')
        end
    },
    'tpope/vim-sleuth',
    'tpope/vim-eunuch',
    {
        'akinsho/toggleterm.nvim',
        opts = {
            size = 20,
            open_mapping = [[<C-t>]]
        }
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
    }
}
