local lsp_client_configs = require('plugins.lsp.clients')

return {
    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },
        build = 'cargo build --release',
        opts = {
            keymap = { preset = 'default' },
            appearance = {
                nerd_font_variant = 'normal',
            },
            signature = { enabled = true },
        },
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = { 'williamboman/mason.nvim' },
        config = function()
            local lspconfig = require('lspconfig')

            -- Diagnostics configuration
            vim.diagnostic.config({
                virtual_lines = true,
                severity_sort = true,
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = '',
                        [vim.diagnostic.severity.WARN] = '',
                        [vim.diagnostic.severity.INFO] = '',
                        [vim.diagnostic.severity.HINT] = '',
                    },
                },
            })

            -- LSP configuration
            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP configuration',
                group = vim.api.nvim_create_augroup('lsp-settings', {}),
                callback = function(args)
                    local client_id = args.data.client_id
                    local client = vim.lsp.get_client_by_id(client_id)
                    assert(client ~= nil)

                    -- If client supports folding, use the client for folding.
                    if client.server_capabilities.foldingRangeProvider then
                        vim.wo.foldmethod = 'expr'
                        vim.wo.foldexpr = 'v:lua.vim.lsp.foldexpr()'
                    end
                end,
            })

            -- Load LSP client configurations.
            for client, config in pairs(lsp_client_configs) do
                lspconfig[client].setup(config)
            end
        end,
    },
}
