local utils = require('utils')
local lspconfig = require('lspconfig')
local wk = require('which-key')

-- Make LSP floating windows have borders
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = "single" }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = "single" }
)

-- Default on_attach for LSP servers
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }

    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<Leader>lwa',
        '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',
        opts
    )
    buf_set_keymap('n', '<Leader>lwr',
        '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',
        opts
    )
    buf_set_keymap('n', '<Leader>lwl',
        '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
        opts
    )
    buf_set_keymap('n', '<Leader>lD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<Leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<C-Space>',
        '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "single" })<CR>',
        opts
    )
    buf_set_keymap('n', ']g',
        '<cmd>lua vim.lsp.diagnostic.goto_next({ popup_opts = { border = "single" }})<CR>',
        opts
    )
    buf_set_keymap('n', '[g',
        '<cmd>lua vim.lsp.diagnostic.goto_prev({ popup_opts = { border = "single" }})<CR>',
        opts
    )
    buf_set_keymap('n', '<Leader>lds', '<C-Space>', { silent = true })
    buf_set_keymap('n', '<Leader>ldn', ']g', { silent = true })
    buf_set_keymap('n', '<Leader>ldp', '[g', { silent = true })

    buf_set_keymap('n', '<Leader>lt', '<cmd>SymbolsOutline<CR>', opts)

    wk.register({
        g = {
            D = "Declaration",
            d = "Definition",
            i = "Implementation",
            r = "References"
        },
        ["]"] = { g = "Next diagnostic" },
        ["["] = { g = "Previous diagnostic" }
    }, { buffer = bufnr })

    local function buf_bind_picker(...)
        require('config.tools.telescope-nvim-utils').buf_bind_picker(bufnr, ...)
    end

    -- Telescope LSP
    buf_bind_picker('<Leader>lsd', 'lsp_document_symbols')
    buf_bind_picker('<Leader>lsw', 'lsp_workspace_symbols')
    buf_bind_picker('<Leader>ldd', 'lsp_document_diagnostics')
    buf_bind_picker('<Leader>ldw', 'lsp_workspace_diagnostics')
    buf_bind_picker('<Leader>lc', 'lsp_code_actions')

    local keys = {
        l = {
            name = '+lsp',
            s = {
                name = '+symbols',
                d = 'Document Symbols',
                w = 'Workspace Symbols'
            },
            d = {
                name = '+diagnostics',
                s = 'Show line diagnostics',
                p = 'Goto prev',
                n = 'Goto next',
                d = 'Document Diagnostics',
                w = 'Workspace Diagnostics'
            },
            c = 'Code Actions',
            w = {
                name = '+workspace',
                a = 'Add workspace folder',
                r = 'Remove workspace folder',
                l = 'List workspace folders'
            },
            D = 'Type definition',
            r = 'Rename',
            t = 'Tags'
        }
    }

    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<space>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

        keys.l.f = 'Format'

        if client.resolved_capabilities.document_range_formatting then
            buf_set_keymap('n', '<space>lF',
                '<cmd>lua vim.lsp.buf.range_formatting()<CR>',
                opts
            )

            keys.l.F = 'Range Format'
        end

    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap(
            'n', '<space>lf',
            '<cmd>lua vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})<CR>',
            opts
        )
        buf_set_keymap('n', '<space>lF',
            '<cmd>lua vim.lsp.buf.range_formatting()<CR>',
            opts
        )

        keys.l.f = 'Format'
        keys.l.F = 'Range Format'
    end

    wk.register(keys, { prefix = "<leader>", buffer = bufnr })

    -- LSP Signatures
    require('lsp_signature').on_attach()
end

-- LSP Server Configurations
local default_config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true;

    return {
        capabilities = capabilities,
        on_attach = on_attach,
    }
end

-- LSP Servers
local servers = {
    'clangd',
    'gdscript',
    'bashls',
    'rust_analyzer',
    'sumneko_lua',
    'pyright',
    'cmake'
}

local lspinstall_path = vim.fn.stdpath('data') .. '/lspinstall/'

for _, server in ipairs(servers) do
    local config = default_config()

    if server == 'sumneko_lua' then
        config.cmd = {
            lspinstall_path .. 'lua/sumneko-lua-language-server',
            '-E', lspinstall_path .. 'lua/main.lua'
        }
        config.settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                    -- Setup your lua path
                    path = vim.split(package.path, ';'),
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = {'vim'},
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = {
                        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                    },
                },
            },
        }
    end

    if server == "rust_analyzer" then
        config.settings = {
            ["rust-analyzer"] = {
                assist = {
                    importMergeBehavior = "last",
                    importPrefix = "by_self",
                },
                cargo = {
                    loadOutDirsFromCheck = true
                },
                procMacro = {
                    enable = true
                },
            }
        }
    end

    if server == "cmake" then
        config.cmd = {
            lspinstall_path .. 'cmake/venv/bin/cmake-language-server'
        }
    end

    lspconfig[server].setup(config)
end
