local lsp_client_configs = require('plugins.lsp.clients')

return {
    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },
        build = 'cargo build --release',
        opts = {
            keymap = 'default',
            accept = { auto_brackets = { enabled = true } },
            trigger = { signature_help = { enabled = true } },
            nerd_font_variant = 'normal',
        },
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = { 'williamboman/mason.nvim' },
        config = function()
            local lspconfig = require('lspconfig')

            -- Diagnostics configuration
            vim.diagnostic.config({
                virtual_text = {
                    spacing = 4,
                    prefix = '~',
                },
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
                    local bufnr = args.buf
                    local client_id = args.data.client_id
                    local client = vim.lsp.get_client_by_id(client_id)
                    assert(client ~= nil)

                    -- Mappings
                    vim.keymap.set(
                        'n',
                        '<Leader>fs',
                        require('telescope.builtin').lsp_dynamic_workspace_symbols,
                        { buffer = bufnr, desc = '[f]ind dynamic workspace [s]ymbols' }
                    )
                    vim.keymap.set(
                        'n',
                        '<Leader>fS',
                        require('telescope.builtin').lsp_document_symbols,
                        { buffer = bufnr, desc = '[f]ind document [S]ymbols' }
                    )
                end,
            })

            -- Load LSP client configurations.
            for client, config in pairs(lsp_client_configs) do
                lspconfig[client].setup(config)
            end
        end,
    },
}
