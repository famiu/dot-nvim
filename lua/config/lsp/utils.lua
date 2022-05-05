local lsp = vim.lsp
local diagnostic = vim.diagnostic
local keymap = vim.keymap
local lspconfig = require('lspconfig')
local utils = require('utils')

local M = {}

-- Utilities to help configuring LSP servers
-- Default on_attach for LSP servers
function M.default_on_attach(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true, buffer = bufnr }

    keymap.set('n', 'gD', function() lsp.buf.declaration() end, opts)
    keymap.set('n', 'gd', function() lsp.buf.definition() end, opts)
    keymap.set('n', 'K', function() lsp.buf.hover() end, opts)
    keymap.set('n', 'gi', function() lsp.buf.implementation() end, opts)
    keymap.set('n', 'gr', function() lsp.buf.references() end, opts)
    keymap.set('n', '<Leader>wa',
        function() lsp.buf.add_workspace_folder() end,
        opts
    )
    keymap.set('n', '<Leader>wr',
        function() lsp.buf.remove_workspace_folder() end,
        opts
    )
    keymap.set('n', '<Leader>wl',
        function() print(vim.inspect(lsp.buf.list_workspace_folders())) end,
        opts
    )
    keymap.set('n', '<Leader>lt', function() lsp.buf.type_definition() end, opts)
    keymap.set('n', '<Leader>r', function() lsp.buf.rename() end, opts)
    keymap.set('n', '<C-Space>',
        function() diagnostic.open_float() end,
        opts
    )
    keymap.set('n', ']g',
        function() diagnostic.goto_next() end,
        opts
    )
    keymap.set('n', '[g',
        function() diagnostic.goto_prev() end,
        opts
    )

    local function buf_bind_picker(...)
        require('config.tools.telescope-nvim-utils').buf_bind_picker(bufnr, ...)
    end

    -- Telescope LSP bindings
    buf_bind_picker('<Leader>ld', 'diagnostics')

    -- Code actions
    keymap.set('n', '<Leader>ca', lsp.buf.code_action, opts)

    if client.supports_method('textDocument/formatting') then
        keymap.set("n", "<space>lf", function() lsp.buf.format() end, opts)
    elseif client.supports_method('textDocument/rangeFormatting') then
        keymap.set(
            'n', '<space>lf',
            function() lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 }) end,
            opts
        )
    end

    if client.supports_method('textDocument/rangeFormatting') then
        keymap.set('v', '<space>lF', function() vim.lsp.buf.range_formatting() end, opts)
    end
end

-- Default capabilities for LSP servers
function M.default_capabilities()
    local capabilities = lsp.protocol.make_client_capabilities()

    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

    return capabilities
end


-- Default config for LSP servers
function M.default_config()
    return {
        capabilities = M.default_capabilities(),
        on_attach = M.default_on_attach
    }
end

-- Function to add formatting on save to an LSP client
function M.format_on_save(client)
    if client.supports_method('textDocument/formatting') then
        utils.create_buf_augroup({
            {
                event = 'BufWritePre',
                opts = { callback = function() lsp.buf.format() end }
            }
        }, 'lsp_auto_format')
    elseif client.supports_method('textDocument/rangeFormatting') then
        utils.create_buf_augroup({
            {
                event = 'BufWritePre',
                opts = {
                    callback = function()
                        lsp.buf.range_formatting({}, {0, 0}, { vim.fn.line("$"), 0 })
                    end
                }
            }
        }, 'lsp_auto_format')
    end
end

-- Setup client with the following config overrides
local function setup_client(client_name, config_overrides)
    config_overrides = config_overrides or {}
    local config = M.default_config()

    for k, v in pairs(config_overrides) do
        config[k] = v
    end

    lspconfig[client_name].setup(config)
end

-- More terse frontend for setup_client
M.clients = setmetatable({}, {
    __index = function(_, key)
        return {
            setup = function(config_overrides)
                setup_client(key, config_overrides)
            end
        }
    end,
    __newindex = function(_, _, _)
    end,
    __metatable = false
})

return M
