local api = vim.api
local fs = vim.fs
local lsp = vim.lsp
local augroup = api.nvim_create_augroup('lsp-settings', { clear = false })
local M = {}

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
function M.configure_lsp(config)
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

            lsp.start(vim.tbl_extend('keep', lsp_start_opts, config), { bufnr = opts.buf })
        end
    })
end

return M
