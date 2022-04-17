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

    keymap.set('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    keymap.set('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    keymap.set('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    keymap.set('n', '<Leader>wa',
        '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',
        opts
    )
    keymap.set('n', '<Leader>wr',
        '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',
        opts
    )
    keymap.set('n', '<Leader>wl',
        '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
        opts
    )
    keymap.set('n', '<Leader>lt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    keymap.set('n', '<Leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    keymap.set('n', '<C-Space>',
        '<cmd>lua vim.diagnostic.open_float()<CR>',
        opts
    )
    keymap.set('n', ']g',
        '<cmd>lua vim.diagnostic.goto_next()',
        opts
    )
    keymap.set('n', '[g',
        '<cmd>lua vim.diagnostic.goto_prev()<CR>',
        opts
    )

    local function buf_bind_picker(...)
        require('config.tools.telescope-nvim-utils').buf_bind_picker(bufnr, ...)
    end

    -- Telescope LSP
    buf_bind_picker('<Leader>ld', 'diagnostics')
    buf_bind_picker('<Leader>lc', 'lsp_code_actions')

    if client.resolved_capabilities.document_formatting then
        keymap.set("n", "<space>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    elseif client.resolved_capabilities.document_range_formatting then
        keymap.set(
            'n', '<space>lf', 
            '<cmd>lua vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})<CR>',
            opts
        )
    end

    if client.resolved_capabilities.document_range_formatting then
        keymap.set('v', '<space>lF', ':lua vim.lsp.buf.range_formatting()<CR>', opts)
    end
end

-- Default capabilities for LSP servers
function M.default_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()

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
    if client.resolved_capabilities.document_formatting then
        utils.create_buf_augroup({
            {
                event = 'BufWritePre',
                opts = { command = 'lua vim.lsp.buf.formatting_sync(nil, 1000)' }
            }
        }, 'lsp_auto_format')
    elseif client.resolved_capabilities.document_range_formatting then
        utils.create_buf_augroup({
            {
                event = 'BufWritePre',
                opts = { command = 'lua vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})' }
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
