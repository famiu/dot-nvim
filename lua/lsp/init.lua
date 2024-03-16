local api = vim.api
local fn = vim.fn
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
    signs = false
}

-- Diagnostic Signs
fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })
fn.sign_define('DiagnosticSignOk', { text = '', texthl = 'DiagnosticSignOk' })

-- LSP configuration
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

-- Load LSP client configurations
require('lsp.clients')
