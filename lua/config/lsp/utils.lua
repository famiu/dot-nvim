local lspconfig = require('lspconfig')
local wk = require('which-key')
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

    local visual_keys = {
        l = {
            name = '+lsp'
        }
    }

    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<space>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

        keys.l.f = 'Format'

        if client.resolved_capabilities.document_range_formatting then
            buf_set_keymap('v', '<space>lF',
                ':lua vim.lsp.buf.range_formatting()<CR>',
                opts
            )

            visual_keys.l.F = 'Range Format'
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

        keys.l.f = 'Format'
        visual_keys.l.F = 'Range Format'
    end

    wk.register(keys, { prefix = '<leader>', buffer = bufnr })
    wk.register(visual_keys, { prefix = '<leader>', mode = 'v', buffer = bufnr })

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

    capabilities.textDocument.completion.completionItem.snippetSupport = true

    return capabilities
end


-- Default config for LSP servers
function M.default_config()
    return {
        capabilities = M.default_capabilities(),
        on_attach = M.default_on_attach
    }
end

-- Utility function to add bindings along with whichkey configuration to buffer
function M.client_add_binds(bufnr, binds, wk_labels, wk_config)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    for _, bind in ipairs(binds) do
        buf_set_keymap(unpack(bind))
    end

    wk_config['buffer'] = bufnr

    if wk_labels then wk.register(wk_labels, wk_config) end
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
