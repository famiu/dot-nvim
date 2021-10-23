local lspconfig = require('lspconfig')
local utils = require('utils')

local M = {}

-- Utilities to help configuring LSP servers
-- Default on_attach for LSP servers
function M.default_on_attach(client, bufnr)
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
    buf_set_keymap('n', '<Leader>wa',
        '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',
        opts
    )
    buf_set_keymap('n', '<Leader>wr',
        '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',
        opts
    )
    buf_set_keymap('n', '<Leader>wl',
        '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
        opts
    )
    buf_set_keymap('n', '<Leader>lt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<Leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
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
    buf_set_keymap('n', '<Leader>ls', '<cmd>SymbolsOutline<CR>', opts)

    local function buf_bind_picker(...)
        require('config.tools.telescope-nvim-utils').buf_bind_picker(bufnr, ...)
    end

    -- Telescope LSP
    buf_bind_picker('<Leader>ld', 'lsp_document_diagnostics')
    buf_bind_picker('<Leader>lD', 'lsp_workspace_diagnostics')
    buf_bind_picker('<Leader>lc', 'lsp_code_actions')

    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<space>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

        if client.resolved_capabilities.document_range_formatting then
            buf_set_keymap('v', '<space>lF',
                ':lua vim.lsp.buf.range_formatting()<CR>',
                opts
            )
        end

    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap(
            'n', '<space>lf',
            '<cmd>lua vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})<CR>',
            opts
        )
        buf_set_keymap('v', '<space>lF',
            ':lua vim.lsp.buf.range_formatting()<CR>',
            opts
        )
    end

    -- LSP Signatures
    require('lsp_signature').on_attach({
        bind = true,
        floating_window = true,
        hint_enable = true,
        hint_prefix = "-> ",
        hint_scheme = "String",
        use_lspsaga = false,
        hi_parameter = "Search",
        handler_opts = {
            border = "single"
        },
    })
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
                'BufWritePre',
                'lua vim.lsp.buf.formatting_sync(nil, 1000)'
            }
        }, 'lsp_auto_format')
    elseif client.resolved_capabilities.document_range_formatting then
        utils.create_buf_augroup({
            {
                'BufWritePre',
                'lua vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})'
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
