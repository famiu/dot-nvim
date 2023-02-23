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
    'tpope/vim-surround',
    'tpope/vim-sleuth',
    'tpope/vim-eunuch',
}
