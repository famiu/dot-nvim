return {
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
    'L3MON4D3/LuaSnip',
    'mfussenegger/nvim-lsp-compl',
}
