return {
    'tpope/vim-sleuth',
    {
        'stevearc/conform.nvim',
        dependencies = { 'neovim/nvim-lspconfig' },
        event = 'BufWritePre',
        cmd = { 'ConformInfo' },
        opts = {
            formatters_by_ft = {
                lua = { 'stylua' },
                python = { 'black' },
                css = { 'prettier' },
                html = { 'prettier' },
                javascript = { 'prettier' },
                typescript = { 'prettier' },
                json = { 'prettier' },
                jsonc = { 'prettier' },
                markdown = { 'prettier' },
            },
        },
        keys = {
            {
                '<Leader>F',
                function()
                    require('conform').format({ async = true, lsp_format = 'first' })
                end,
                mode = { 'n', 'x' },
            },
        },
        init = function()
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
    },
}
