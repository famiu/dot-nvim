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
            max_concurrent_installers = PU_COUNT
        }
    },
    { 'folke/neodev.nvim',  opts = { lspconfig = false } },
    { 'ggandor/leap.nvim', config = function() require('leap').add_default_mappings(true) end },
    { dir = '~/Workspace/neovim/bufdelete' }, -- https://github.com/famiu/bufdelete.nvim
    { 'numToStr/Comment.nvim', config = true },
    { 'windwp/nvim-autopairs', config = true },
    { 'echasnovski/mini.align', config = function() require('mini.align').setup() end },
    'tpope/vim-surround',
    'tpope/vim-sleuth',
    'tpope/vim-eunuch',
}
