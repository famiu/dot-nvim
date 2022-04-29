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
vim.diagnostic.config {
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

-- Diagnostic Signs
fn.sign_define('DiagnosticSignError', {text = '✗', texthl = 'DiagnosticSignError'})
fn.sign_define('DiagnosticSignWarn', {text = '', texthl = 'DiagnosticSignWarn'})
fn.sign_define('DiagnosticSignInfo', {text = '', texthl = 'DiagnosticSignInfo'})
fn.sign_define('DiagnosticSignHint', {text = '', texthl = 'DiagnosticSignHint'})

vim.lsp.protocol.CompletionItemKind = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "ﰠ",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "塞",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "פּ",
    Event = "",
    Operator = "",
    TypeParameter = ""
}

-- Setup LSP Installer
require("nvim-lsp-installer").setup {
    ensure_installed = { 'sumneko_lua', 'vimls' },
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
}

-- Load client configurations
require('config.lsp.clients')
