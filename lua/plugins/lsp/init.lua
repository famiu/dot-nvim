local client_configs = require('plugins.lsp.clients')

return {
    {
        'saghen/blink.cmp',
        build = function()
            require('blink.cmp').build():pwait()
        end,
        dependencies = { 'saghen/blink.lib' },
        opts = {
            keymap = {
                preset = 'default',
                ['<Tab>'] = {
                    'snippet_forward',
                    function() -- if you are using Neovim's native inline completions
                        return vim.lsp.inline_completion.get()
                    end,
                    'fallback',
                },
            },
            appearance = { nerd_font_variant = 'normal' },
            signature = { enabled = true },
            cmdline = {
                keymap = { preset = 'inherit' },
                completion = { menu = { auto_show = true } },
            },
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
                    if client:supports_method('textDocument/foldingRange', args.buf) then
                        vim.wo.foldmethod = 'expr'
                        vim.wo.foldexpr = vim.lsp.foldexpr
                    end

                    -- Enable code lens for supported clients.
                    if client:supports_method('textDocument/codeLens', args.buf) then
                        vim.lsp.codelens.enable(true, { bufnr = args.buf, client_id = client.id })
                    end

                    -- Enable linked editing for supported clients.
                    if client:supports_method('textDocument/linkedEditingRange', args.buf) then
                        vim.lsp.linked_editing_range.enable(true, { bufnr = args.buf, client_id = client.id })
                    end

                    -- Enable inline completion for supported clients.
                    if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion, args.buf) then
                        vim.lsp.inline_completion.enable(true, { bufnr = args.buf })
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
}
