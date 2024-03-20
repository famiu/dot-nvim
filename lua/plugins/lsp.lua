local api = vim.api
local fn = vim.fn

local lsp_client_configs = {
    lua_ls = {
        cmd = { 'lua-language-server' },
        settings = {
            Lua = {
                workspace = {
                    checkThirdParty = false,
                },
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
                    version = 'LuaJIT',
                },
                -- Make the server aware of Neovim runtime files.
                workspace = {
                    library = workspace_libraries,
                },
            })
        end,
    },
    clangd = {
        cmd = { 'clangd', '--background-index', '--clang-tidy' },
    },
    rust_analyzer = {
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
    },
    bashls = {
        filetypes = { 'sh', 'bash', 'zsh' },
    },
    cmake = {
        cmd = { 'cmake-language-server' },
    },
    pyright = {},
}

return {
    'neovim/nvim-lspconfig',
    event = 'FileType',
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
                vim.tbl_map(
                    function(mapping)
                        vim.keymap.set(
                            mapping.mode or 'n',
                            mapping[1],
                            mapping[2],
                            { buffer = bufnr, desc = mapping.desc }
                        )
                    end,
                    {
                        { 'gD', function() lsp.buf.declaration() end, desc = '[g]o to [D]eclaration' },
                        { '<Leader>r', function() lsp.buf.rename() end, desc = '[r]ename symbol' },
                        { ']d', function() diagnostic.goto_next() end, desc = 'Go to next [d]iagnostic' },
                        { '[d', function() diagnostic.goto_prev() end, desc = 'Go to previous [d]iagnostic' },
                        { '<C-Space>', function() diagnostic.open_float() end, desc = 'Open diagnostic float' },
                        { '<Leader>ca', function() lsp.buf.code_action() end, desc = 'Perform [c]ode [a]ction' },
                        -- Telescope mappings
                        {
                            'gd',
                            function() require('telescope.builtin').lsp_definitions() end,
                            desc = '[g]oto [d]efinition',
                        },
                        {
                            'gi',
                            function() require('telescope.builtin').lsp_implementations() end,
                            desc = '[g]oto [i]mplementation',
                        },
                        {
                            'gr',
                            function() require('telescope.builtin').lsp_references() end,
                            desc = '[g]oto [r]eferences',
                        },
                        {
                            'gT',
                            function() require('telescope.builtin').lsp_type_definitions() end,
                            desc = '[g]oto [T]ype definitions',
                        },
                        {
                            '<Leader>fs',
                            function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end,
                            desc = '[f]ind dynamic workspace [s]ymbols',
                        },
                        {
                            '<Leader>fS',
                            function() require('telescope.builtin').lsp_document_symbols() end,
                            desc = '[f]ind document [S]ymbols',
                        },
                    }
                )
            end,
        })

        -- Load LSP client configurations.
        for client, config in pairs(lsp_client_configs) do
            lspconfig[client].setup(config)
        end
    end,
}
