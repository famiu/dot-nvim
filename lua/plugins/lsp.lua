local api = vim.api
local fn = vim.fn
local lsp = vim.lsp
local diagnostic = vim.diagnostic
local keymap = vim.keymap

return {
    'neovim/nvim-lspconfig',

    dependencies = {
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'SmiteshP/nvim-navic',
    },

    config = function()
        local augroup = api.nvim_create_augroup('lsp-settings', {})
        local navic = require('nvim-navic')
        local lspconfig = require('lspconfig')
        local default_capabilities = require('cmp_nvim_lsp').default_capabilities()

        -- Make LSP floating windows have borders.
        lsp.handlers['textDocument/hover'] = lsp.with(
            lsp.handlers.hover,
            { border = 'single' }
        )

        lsp.handlers['textDocument/signatureHelp'] = lsp.with(
            lsp.handlers.signature_help,
            { border = 'single' }
        )

        -- Diagnostics configuration.
        diagnostic.config {
            virtual_text = {
                spacing = 4,
                prefix = '~',
            },
            signs = false
        }

        -- Diagnostic Signs.
        fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
        fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
        fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
        fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })
        fn.sign_define('DiagnosticSignOk', { text = '', texthl = 'DiagnosticSignOk' })

        -- LSP configuration.
        api.nvim_create_autocmd('LspAttach', {
            desc = 'LSP configuration',
            group = augroup,
            callback = function(args)
                local bufnr = args.buf
                local client = lsp.get_client_by_id(args.data.client_id)
                assert(client ~= nil)

                -- Mappings.
                local opts = { buffer = bufnr }
                keymap.set('n', 'gD', function() lsp.buf.declaration() end, opts)
                keymap.set('n', '<Leader>r', function() lsp.buf.rename() end, opts)
                keymap.set('n', '<C-Space>', function() diagnostic.open_float() end, opts)
                keymap.set('n', ']e', function() diagnostic.goto_next() end, opts)
                keymap.set('n', '[e', function() diagnostic.goto_prev() end, opts)
                keymap.set('n', '<Leader>ca', lsp.buf.code_action, opts)

                -- Telescope mappings
                keymap.set(
                    'n', 'gd',
                    function() require('telescope.builtin').lsp_definitions() end,
                    opts
                )
                keymap.set(
                    'n', 'gi',
                    function() require('telescope.builtin').lsp_implementations() end,
                    opts
                )
                keymap.set(
                    'n', 'gr',
                    function() require('telescope.builtin').lsp_references() end,
                    opts
                )
                keymap.set(
                    'n', 'gT',
                    function() require('telescope.builtin').lsp_type_definitions() end,
                    opts
                )
                keymap.set(
                    'n', '<Leader>fS',
                    function() require('telescope.builtin').lsp_document_symbols() end,
                    opts
                )
                keymap.set(
                    'n', '<Leader>fs',
                    function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end,
                    opts
                )

                if client.supports_method('textDocument/formatting') then
                    keymap.set({ 'n', 'v' }, '<space>lf', function() lsp.buf.format() end, opts)
                end

                if client.server_capabilities.documentSymbolProvider then
                    navic.attach(client, bufnr)
                end
            end
        })

        -- Set default Lspconfig capabilities.
        lspconfig.util.default_config.capabilities = default_capabilities

        -- Load LSP client configurations.
        lspconfig.clangd.setup {
            cmd = { 'clangd', '--background-index', '--clang-tidy' },
        }

        lspconfig.rust_analyzer.setup {
            settings = {
                ['rust-analyzer'] = {
                    check = {
                        command = 'clippy',
                    },
                    diagnostics = {
                        experimental = {
                            enable = true,
                        },
                    },
                    rustfmt = {
                        extraArgs = { '+nightly' },
                        rangeFormatting = {
                            enable = true,
                        },
                    },
                },
            },
        }

        lspconfig.pyright.setup {}

        lspconfig.lua_ls.setup {
            cmd = { 'lua-language-server' },
            settings = {
                Lua = {
                    workspace = {
                        checkThirdParty = false
                    }
                },
            },
            on_init = function(client)
                local nvim_runtime_dirs = vim.api.nvim_get_runtime_file('', true)
                local is_nvim_lua = false

                if require('utilities.os').is_windows() then
                    -- Use forward slashes for Windows paths in runtime_dirs since root_dir uses forward slashes.
                    for i, dir in ipairs(nvim_runtime_dirs) do
                        nvim_runtime_dirs[i] = dir:gsub('\\', '/')
                    end
                end

                -- Check if the root_dir is inside a Neovim runtime directory.
                for _, dir in ipairs(nvim_runtime_dirs) do
                    if vim.startswith(client.config.root_dir, dir) then
                        is_nvim_lua = true
                        break
                    end
                end

                if not is_nvim_lua then
                    return
                end

                local workspace_libraries = nvim_runtime_dirs
                -- Add busted and luv to the workspace library.
                table.insert(workspace_libraries, '${3rd}/luv/library')
                table.insert(workspace_libraries, '${3rd}/busted/library')

                client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                    runtime = {
                        version = 'LuaJIT'
                    },
                    -- Make the server aware of Neovim runtime files.
                    workspace = {
                        checkThirdParty = false,
                        library = workspace_libraries,
                    }
                })
            end,
        }

        lspconfig.bashls.setup {
            filetypes = { 'sh', 'bash', 'zsh' },
        }

        lspconfig.cmake.setup {
            cmd = { 'cmake-language-server' },
        }
    end
}
