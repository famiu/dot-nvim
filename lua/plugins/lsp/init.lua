local client_configs = require('plugins.lsp.clients')

return {
    {
        'saghen/blink.cmp',
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
        config = function()
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
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    assert(client ~= nil)

                    -- If client supports folding, use the client for folding.
                    if client.server_capabilities.foldingRangeProvider then
                        vim.wo.foldmethod = 'expr'
                        vim.wo.foldexpr = 'v:lua.vim.lsp.foldexpr()'
                    end

                    -- Enable document color for supported clients.
                    if client:supports_method('textDocument/documentColor') then
                        vim.lsp.document_color.enable(true, args.buf)
                    end
                end,
            })

            -- Load LSP client configurations.
            for server, config in pairs(client_configs) do
                if next(config) ~= nil then
                    vim.lsp.config(server, config)
                end

                vim.lsp.enable(server)
            end
        end,
    },
    {
        'mfussenegger/nvim-lint',
        init = function()
            require('lint').linters_by_ft = {
                python = { 'mypy' },
            }

            vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
                desc = 'Lint configuration',
                group = vim.api.nvim_create_augroup('NvimLint', {}),
                callback = function()
                    require('lint').try_lint()
                end,
            })
        end,
    },
}
