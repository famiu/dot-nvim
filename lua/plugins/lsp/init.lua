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
                    current_line = false,
                    spacing = 4,
                    prefix = '~',
                },
                virtual_lines = {
                    current_line = true,
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
            vim.lsp.codelens.enable()
            vim.lsp.inlay_hint.enable()
            vim.lsp.inline_completion.enable()
            vim.lsp.linked_editing_range.enable()
            vim.lsp.on_type_formatting.enable()

            local lsp_augroup = vim.api.nvim_create_augroup('lsp-settings', {})

            vim.api.nvim_create_autocmd('InsertEnter', {
                desc = 'Disable LSP inlay hints in Insert mode',
                group = lsp_augroup,
                callback = function(args)
                    local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf })
                    vim.b[args.buf].inlay_hints_enabled_before_insert = enabled

                    if enabled then
                        vim.lsp.inlay_hint.enable(false, { bufnr = args.buf })
                    end
                end,
            })

            vim.api.nvim_create_autocmd('InsertLeave', {
                desc = 'Restore LSP inlay hints after Insert mode',
                group = lsp_augroup,
                callback = function(args)
                    if vim.b[args.buf].inlay_hints_enabled_before_insert then
                        vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
                    end

                    vim.b[args.buf].inlay_hints_enabled_before_insert = nil
                end,
            })

            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP configuration',
                group = lsp_augroup,
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    assert(client ~= nil)

                    -- If client supports folding, use the client for folding.
                    if client:supports_method('textDocument/foldingRange', args.buf) then
                        vim.wo.foldmethod = 'expr'
                        vim.wo.foldexpr = vim.lsp.foldexpr
                        vim.wo.foldtext = vim.lsp.foldtext
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
