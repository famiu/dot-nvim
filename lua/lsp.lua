local api = vim.api
local fn = vim.fn
local fs = vim.fs
local lsp = vim.lsp
local diagnostic = vim.diagnostic
local keymap = vim.keymap
local navic = require('nvim-navic')
local augroup = api.nvim_create_augroup('lsp-settings', {})

-- Make LSP floating windows have borders
lsp.handlers['textDocument/hover'] = lsp.with(
    lsp.handlers.hover,
    { border = 'single' }
)

lsp.handlers['textDocument/signatureHelp'] = lsp.with(
    lsp.handlers.signature_help,
    { border = 'single' }
)

-- Diagnostics configuration
diagnostic.config {
    virtual_text = {
        spacing = 4,
        prefix = '~',
    },
}

-- Diagnostic Signs
fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })
fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignOk' })

lsp.protocol.CompletionItemKind = {
    Text          = '',
    Method        = '',
    Function      = '',
    Constructor   = '',
    Field         = 'ﰠ',
    Variable      = '',
    Class         = 'ﴯ',
    Interface     = '',
    Module        = '',
    Property      = 'ﰠ',
    Unit          = '塞',
    Value         = '',
    Enum          = '',
    Keyword       = '',
    Snippet       = '',
    Color         = '',
    File          = '',
    Reference     = '',
    Folder        = '',
    EnumMember    = '',
    Constant      = '',
    Struct        = 'פּ',
    Event         = '',
    Operator      = '',
    TypeParameter = ''
}

-- LSP configuration
api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP configuration',
    callback = function(args)
        local bufnr = args.buf
        local client = lsp.get_client_by_id(args.data.client_id)

        -- Mappings.
        local opts = { buffer = bufnr }
        keymap.set('n', 'gD', function() lsp.buf.declaration() end, opts)
        keymap.set('n', 'gd', function() lsp.buf.definition() end, opts)
        keymap.set('n', 'K', function() lsp.buf.hover() end, opts)
        keymap.set('n', 'gi', function() lsp.buf.implementation() end, opts)
        keymap.set('n', 'gr', function() lsp.buf.references() end, opts)
        keymap.set('n', '<Leader>wa', function() lsp.buf.add_workspace_folder() end, opts)
        keymap.set('n', '<Leader>wr', function() lsp.buf.remove_workspace_folder() end, opts)
        keymap.set('n', '<Leader>wl',
            function() print(vim.inspect(lsp.buf.list_workspace_folders())) end,
            opts)
        keymap.set('n', '<Leader>lt', function() lsp.buf.type_definition() end, opts)
        keymap.set('n', '<Leader>r', function() lsp.buf.rename() end, opts)
        keymap.set('n', '<C-Space>', function() diagnostic.open_float() end, opts)
        keymap.set('n', ']g', function() diagnostic.goto_next() end, opts)
        keymap.set('n', '[g', function() diagnostic.goto_prev() end, opts)
        keymap.set('n', '<Leader>ca', lsp.buf.code_action, opts)

        -- Telescope mappings (lazy-loaded)
        keymap.set('n', '<Leader>fS',
            function() require('telescope.builtin').lsp_document_symbols() end,
            opts)
        keymap.set('n', '<Leader>fs',
            function() require('telescope.builtin').lsp_workspace_symbols() end,
            opts)

        if client.supports_method('textDocument/formatting') then
            keymap.set({ 'n', 'v' }, '<space>lf', function() lsp.buf.format() end, opts)
        end

        if client.server_capabilities.documentSymbolProvider then
            navic.attach(client, bufnr)
        end
    end
})

-- Configure LSP servers
local function buf_parent_dir(bufnr)
    return fs.dirname(api.nvim_buf_get_name(bufnr))
end

local function find_git_root(bufnr)
    return fs.dirname(fs.find('.git', { upward = true, path = buf_parent_dir(bufnr) })[1])
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

api.nvim_create_autocmd('FileType', {
    pattern = { 'c', 'cpp' },
    group = augroup,
    callback = function(opts)
        lsp.start {
            name = 'clangd',
            cmd = { 'clangd', '--background-index' },
            root_dir = fs.dirname(fs.find({ 'compile_commands.json', '.git' },
                { upward = true, path = buf_parent_dir(opts.buf) })[1]),
            capabilities = capabilities
        }
    end
})

api.nvim_create_autocmd('FileType', {
    pattern = 'rust',
    group = augroup,
    callback = function(opts)
        lsp.start {
            name = 'rust-analyzer',
            cmd = { 'rust-analyzer' },
            root_dir = fs.dirname(fs.find({ 'Cargo.toml', '.git' },
                { upward = true, path = buf_parent_dir(opts.buf) })[1]),
            capabilities = capabilities
        }
    end
})

api.nvim_create_autocmd('FileType', {
    pattern = 'python',
    group = augroup,
    callback = function(opts)
        lsp.start {
            name = 'pyright',
            cmd = { 'pyright-langserver', '--stdio' },
            root_dir = fs.dirname(fs.find({ 'setup.py', 'requirements.txt', 'Pipfile', '.git' },
                { upward = true, path = buf_parent_dir(opts.buf) })[1]),
            capabilities = capabilities
        }
    end
})

api.nvim_create_autocmd('FileType', {
    pattern = 'lua',
    group = augroup,
    callback = function(opts)
        lsp.start {
            name = 'lua-language-server',
            cmd = { 'lua-language-server' },
            root_dir = find_git_root(opts.buf),
            before_init = require('neodev.lsp').before_init,
            capabilities = capabilities
        }
    end
})

api.nvim_create_autocmd('FileType', {
    pattern = { 'sh', 'bash', 'zsh' },
    group = augroup,
    callback = function(opts)
        lsp.start {
            name = 'bash-language-server',
            cmd = { 'bash-language-server', 'start' },
            root_dir = find_git_root(opts.buf),
            capabilities = capabilities
        }
    end
})

api.nvim_create_autocmd('FileType', {
    pattern = 'cmake',
    group = augroup,
    callback = function(opts)
        lsp.start {
            name = 'cmake-language-server',
            cmd = { 'cmake-language-server' },
            root_dir = find_git_root(opts.buf),
            capabilities = capabilities
        }
    end
})
