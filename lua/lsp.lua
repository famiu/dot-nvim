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
        keymap.set(
            'n', '<Leader>wl',
            function() print(vim.inspect(lsp.buf.list_workspace_folders())) end,
            opts
        )
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

        -- Auto-enable inlay hints only in normal mode
        if client.server_capabilities.inlayHintProvider then
            lsp.buf.inlay_hint(bufnr, api.nvim_get_mode().mode:sub(1,1) ~= 'i')

            api.nvim_create_autocmd({ "InsertEnter", "InsertLeave", "BufEnter" }, {
                group = augroup,
                buffer = bufnr,
                callback = function(au_opts)
                    local enable

                    if au_opts.event == "InsertEnter" then
                        enable = false
                    elseif au_opts.event == "InsertLeave" then
                        enable = true
                    else
                        enable = vim.api.nvim_get_mode().mode:sub(1,1) ~= 'i'
                    end

                    lsp.buf.inlay_hint(bufnr, enable)
                end,
            })
        end
    end
})

-- Configure LSP servers
local function buf_parent_dir(bufnr)
    return fs.dirname(api.nvim_buf_get_name(bufnr))
end

local function buf_find_root(bufnr, pattern)
    return fs.dirname(fs.find(pattern, { upward = true, path = buf_parent_dir(bufnr) })[1])
end

local function default_capabilities()
    return require('cmp_nvim_lsp').default_capabilities()
end

-- Configure an LSP server.
--
-- Takes a single configuration dict. The following keys are required:
--   - name (string) : Name of the LSP serverlsp
--   - ftpattern (string | array[string]) : Filetype pattern(s) that trigger the LSP server
--   - cmd (array[string]) : Command used to launch the LSP server
--   - root_pattern (string | array[string]) : Patterns used to find the root_dir
--   - capabilities (table) (optional) : Capability overrides
--
-- All other provided keys are passed to vim.lsp.start()
local function configure_lsp(config)
    local function validate_config_key(key, expected_type, is_optional, default)
        local val = config[key]
        config[key] = nil

        if val == nil then
            if not is_optional then
                vim.api.nvim_err_writeln(
                    string.format([[Required key '%s' is not provided in LSP configuration]], key)
                )
            end

            return default
        elseif not vim.tbl_contains(expected_type, type(val)) then
            vim.api.nvim_err_writeln(
                string.format(
                    [[Invalid type '%s' for '%s'. Expected one of: %s]],
                    type(val),
                    key,
                    table.concat(expected_type, ', ')
                )
            )

            return default
        else
            return val
        end
    end

    local name = validate_config_key('name', { 'string' })
    local ftpattern = validate_config_key('ftpattern', { 'string', 'table' })
    local cmd = validate_config_key('cmd', { 'table' })
    local root_pattern = validate_config_key('root_pattern', { 'string', 'table' })
    local final_capabilities = vim.tbl_extend(
        'force',
        default_capabilities(),
        validate_config_key('capabilities', { 'table' }, true, {})
    )

    if name == nil or ftpattern == nil or cmd == nil or root_pattern == nil then return end

    api.nvim_create_autocmd('FileType', {
        pattern = ftpattern,
        group = augroup,
        callback = function(opts)
            local lsp_start_opts = {
                name = name,
                cmd = cmd,
                root_dir = buf_find_root(opts.buf, root_pattern),
                capabilities = final_capabilities
            }

            lsp.start(vim.tbl_extend('keep', lsp_start_opts, config))
        end
    })
end

configure_lsp {
    name = 'clangd',
    ftpattern = { 'c', 'cpp' },
    cmd = { 'clangd', '--background-index', '--clang-tidy' },
    root_pattern = { 'compile_commands.json', '.git' },
}

configure_lsp {
    name = 'rust-analyzer',
    ftpattern = 'rust',
    cmd = { 'rust-analyzer' },
    root_pattern = { 'Cargo.toml', '.git' },
}

configure_lsp {
    name = 'pyright',
    ftpattern = 'python',
    cmd = { 'pyright-langserver', '--stdio' },
    root_pattern = { 'setup.py', 'requirements.txt', 'Pipfile', '.git' },
}

configure_lsp {
    name = 'lua-language-server',
    ftpattern = 'lua',
    cmd = { os.getenv('HOME') .. '/Workspace/neovim/lua-language-server/bin/lua-language-server' },
    root_pattern = '.git',
    before_init = require('neodev.lsp').before_init,
    settings = {
        Lua = {
            workspace = {
                checkThirdParty = false
            }
        }
    }
}

configure_lsp {
    name = 'bash-language-server',
    ftpattern = { 'sh', 'bash', 'zsh' },
    cmd = { 'bash-language-server', 'start' },
    root_pattern = '.git',
}

configure_lsp {
    name = 'cmake-language-server',
    ftpattern = 'cmake',
    cmd = { 'cmake-language-server' },
    root_pattern = '.git',
}
