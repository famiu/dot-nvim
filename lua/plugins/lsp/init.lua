local lsp_client_configs = require('plugins.lsp.clients')

return {
    'neovim/nvim-lspconfig',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
        local lspconfig = require('lspconfig')

        -- Diagnostics configuration.
        vim.diagnostic.config({
            virtual_text = {
                spacing = 4,
                prefix = '~',
            },
            signs = false,
        })

        -- Diagnostic Signs.
        vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
        vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
        vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
        vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })
        vim.fn.sign_define('DiagnosticSignOk', { text = '', texthl = 'DiagnosticSignOk' })

        -- LSP configuration.
        vim.api.nvim_create_autocmd('LspAttach', {
            desc = 'LSP configuration',
            group = vim.api.nvim_create_augroup('lsp-settings', {}),
            callback = function(args)
                local bufnr = args.buf
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                assert(client ~= nil)

                -- Mappings.
                vim.tbl_map(function(mapping)
                    vim.keymap.set(mapping.mode or 'n', mapping[1], mapping[2], { buffer = bufnr, desc = mapping.desc })
                end, {
                    {
                        'gd',
                        vim.lsp.buf.definition,
                        desc = '[g]oto [d]efinition',
                    },
                    {
                        'gD',
                        vim.lsp.buf.declaration,
                        desc = '[g]o to [D]eclaration',
                    },
                    {
                        'gi',
                        vim.lsp.buf.implementation,
                        desc = '[g]oto [i]mplementation',
                    },
                    {
                        'gr',
                        vim.lsp.buf.references,
                        desc = '[g]oto [r]eferences',
                    },
                    {
                        'gT',
                        vim.lsp.buf.type_definition,
                        desc = '[g]oto [T]ype definitions',
                    },
                    {
                        '<Leader>r',
                        vim.lsp.buf.rename,
                        desc = '[r]ename symbol',
                    },
                    {
                        '<Leader>ca',
                        vim.lsp.buf.code_action,
                        desc = 'Perform [c]ode [a]ction',
                    },
                    -- Telescope mappings
                    {
                        '<Leader>fs',
                        require('telescope.builtin').lsp_dynamic_workspace_symbols,
                        desc = '[f]ind dynamic workspace [s]ymbols',
                    },
                    {
                        '<Leader>fS',
                        require('telescope.builtin').lsp_document_symbols,
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
