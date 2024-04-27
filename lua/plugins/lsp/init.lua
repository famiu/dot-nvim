local api = vim.api
local fn = vim.fn

local lsp_client_configs = require('plugins.lsp.clients')

return {
    'neovim/nvim-lspconfig',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
        local diagnostic = vim.diagnostic
        local lspconfig = require('lspconfig')

        -- Diagnostics configuration.
        diagnostic.config({
            virtual_text = {
                spacing = 4,
                prefix = '~',
            },
            signs = false,
        })

        -- Diagnostic Signs.
        fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
        fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
        fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
        fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })
        fn.sign_define('DiagnosticSignOk', { text = '', texthl = 'DiagnosticSignOk' })

        -- LSP configuration.
        api.nvim_create_autocmd('LspAttach', {
            desc = 'LSP configuration',
            group = api.nvim_create_augroup('lsp-settings', {}),
            callback = function(args)
                local lsp = vim.lsp
                local bufnr = args.buf
                local client = lsp.get_client_by_id(args.data.client_id)
                assert(client ~= nil)

                -- Mappings.
                vim.tbl_map(function(mapping)
                    vim.keymap.set(mapping.mode or 'n', mapping[1], mapping[2], { buffer = bufnr, desc = mapping.desc })
                end, {
                    {
                        'gD',
                        function()
                            lsp.buf.declaration()
                        end,
                        desc = '[g]o to [D]eclaration',
                    },
                    -- Telescope mappings
                    {
                        'gd',
                        function()
                            require('telescope.builtin').lsp_definitions()
                        end,
                        desc = '[g]oto [d]efinition',
                    },
                    {
                        'gi',
                        function()
                            require('telescope.builtin').lsp_implementations()
                        end,
                        desc = '[g]oto [i]mplementation',
                    },
                    {
                        'gT',
                        function()
                            require('telescope.builtin').lsp_type_definitions()
                        end,
                        desc = '[g]oto [T]ype definitions',
                    },
                    {
                        '<Leader>fs',
                        function()
                            require('telescope.builtin').lsp_dynamic_workspace_symbols()
                        end,
                        desc = '[f]ind dynamic workspace [s]ymbols',
                    },
                    {
                        '<Leader>fS',
                        function()
                            require('telescope.builtin').lsp_document_symbols()
                        end,
                        desc = '[f]ind document [S]ymbols',
                    },
                })
            end,
        })

        -- Load LSP client configurations.
        for client, config in pairs(lsp_client_configs) do
            lspconfig[client].setup(config)
        end
    end,
}
