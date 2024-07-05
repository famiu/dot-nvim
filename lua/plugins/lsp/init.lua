local lsp_client_configs = require('plugins.lsp.clients')

return {
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

                -- Auto-complete
                vim.lsp.completion.enable(true, client_id, bufnr, { autotrigger = true })

                -- Signature help
                require('lsp_signature').on_attach({}, bufnr)

                -- Mappings
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
