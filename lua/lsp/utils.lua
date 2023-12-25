local api = vim.api
local fs = vim.fs
local lsp = vim.lsp
local augroup = api.nvim_create_augroup('lsp-settings', { clear = false })
local M = {}
M.filetype_lsp_configs = {}

local function buf_parent_dir(bufnr)
    return fs.dirname(api.nvim_buf_get_name(bufnr))
end

local function buf_find_root(bufnr, pattern)
    return fs.dirname(fs.find(pattern, { upward = true, path = buf_parent_dir(bufnr) })[1])
end

local function default_capabilities()
    return require('cmp_nvim_lsp').default_capabilities()
end

function M.lsp_start(buf)
    local filetype = vim.bo[buf].filetype

    for _, config_fn in ipairs(M.filetype_lsp_configs[filetype]) do
        local config_dict = config_fn(buf)
        lsp.start(config_dict, { bufnr = buf })
    end
end

function M.lsp_stop(buf)
    lsp.stop_client(lsp.get_clients({ bufnr = buf }), true)
end

function M.lsp_restart(buf)
    M.lsp_stop(buf)

    local autocmd
    autocmd = api.nvim_create_autocmd('LspDetach', {
        desc = 'Start LSP servers after all LSP servers are detached',
        group = augroup,
        buffer = buf,
        callback = function()
            -- If this is the last LSP server, delete the autocommand and restart LSP servers.
            if #lsp.get_clients({ bufnr = buf }) == 1 then
                api.nvim_del_autocmd(autocmd)
                vim.schedule(function() M.lsp_start(buf) end)
            end
        end
    })
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

    -- Convert ftpattern to table.
    if type(ftpattern) == 'string' then
        ftpattern = { ftpattern }
    end

    -- Iterate over each filetype in the filetype pattern list, adding the current LSP configuration
    -- to each filetype's LSP configuration list. Also add an autocommand for each filetype that
    -- starts all LSP servers for that filetype, if needed.
    for _, filetype in ipairs(ftpattern) do
        if M.filetype_lsp_configs[filetype] == nil then
            M.filetype_lsp_configs[filetype] = {}

            -- Add autocommand to start all LSP servers associated with that filetype.
            -- Only do it once when initializing the filetype's LSP server configuration list.
            api.nvim_create_autocmd('FileType', {
                pattern = filetype,
                group = augroup,
                callback = function(opts)
                    M.lsp_start(opts.buf)
                end
            })
        end

        -- Add function to generate LSP configuration for the filetype to filetype_lsp_configs.
        local filetype_configs = M.filetype_lsp_configs[filetype]
        filetype_configs[#filetype_configs+1] = function(buf)
            return vim.tbl_extend('keep', {
                name = name,
                cmd = cmd,
                root_dir = buf_find_root(buf, root_pattern),
                capabilities = final_capabilities
            }, config)
        end
    end
end

-- Add LspStart, LspStop and LspRestart commands.
vim.api.nvim_create_user_command('LspStart', function() M.lsp_start(0) end,
    { desc = 'Start LSP servers for buffer' })

vim.api.nvim_create_user_command('LspStop', function() M.lsp_stop(0) end,
    { desc = 'Stop running LSP servers for buffer' })

vim.api.nvim_create_user_command('LspRestart', function() M.lsp_restart(0) end,
    { desc = 'Restart running LSP servers for buffer' })

return M
