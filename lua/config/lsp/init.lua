local lsp = vim.lsp
local fn = vim.fn

-- Make LSP floating windows have borders
lsp.handlers["textDocument/hover"] = lsp.with(
    lsp.handlers.hover,
    { border = "single" }
)

lsp.handlers["textDocument/signatureHelp"] = lsp.with(
    lsp.handlers.signature_help,
    { border = "single" }
)

-- Diagnostics configuration
-- Diagnostics
lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(
    lsp.diagnostic.on_publish_diagnostics,
    {
        underline = true,
        virtual_text = {
            spacing = 4,
            prefix = '~',
        },
        signs = {
            -- Use a function to dynamically turn signs off
            -- and on, using buffer local variables
            enable = function(bufnr, _)
                local ok, result = pcall(vim.api.nvim_buf_get_var, bufnr, 'show_signs')
                -- No buffer local variable set, so just enable by default
                if not ok then
                    return true
                end

                return result
            end,

            priority = 20
        },
        -- Don't update in insert
        update_in_insert = false,
    }
)

-- Diagnostic Signs
fn.sign_define('LspDiagnosticsSignError',
    { text = '✗', texthl = 'LspDiagnosticsSignError' })

fn.sign_define('LspDiagnosticsSignWarning',
    { text = '', texthl = 'LspDiagnosticsSignWarning' })

fn.sign_define('LspDiagnosticsSignInformation',
    { text = '', texthl = 'LspDiagnosticsSignInformation' })

fn.sign_define('LspDiagnosticsSignHint',
    { text = '', texthl = 'LspDiagnosticsSignHint' })

-- LSP Item Kinds
require('vim.lsp.protocol').CompletionItemKind = {
    '', -- Text
    'ƒ', -- Method
    '', -- Function
    '', -- Constructor
    '', -- Field
    '', -- Variable
    '', -- Class
    'ﰮ', -- Interface
    '', -- Module
    '', -- Property
    '', -- Unit
    '', -- Value
    '了', -- Enum
    '', -- Keyword
    '﬌', -- Snippet
    '', -- Color
    '', -- File
    '', -- Reference
    '', -- Folder
    '', -- EnumMember
    '', -- Constant
    '', -- Struct
    '', -- Event
    'ﬦ', -- Operator
    '', -- TypeParameter
}

-- Load client configuration
require('config.lsp.clients')

-- Load LSP-related plugins
require('config.lsp.lightbulb')
require('config.lsp.symbols-outline')
