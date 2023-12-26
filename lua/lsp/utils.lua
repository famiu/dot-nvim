--- @class LspConfig: lsp.ClientConfig
--- @field name string
--- @field ftpattern string|string[]
--- @field cmd string[]
--- @field root_pattern string|string[]
--- @field capabilities? lsp.ServerCapabilities
--- @field settings? table

--- @alias LspClientTarget string|integer
--- @alias LspConfigClientTarget string
--- @alias LspConfigGenerator fun(buf: buffer): LspConfig

local api = vim.api
local fs = vim.fs
local lsp = vim.lsp
local augroup = api.nvim_create_augroup('lsp-settings', { clear = false })
local M = {}
--- @type table<string, table<string, LspConfigGenerator>>
M.filetype_lsp_configs = {}

--- Get parent directory for file in buffer.
---
--- @param buf buffer
local function buf_parent_dir(buf)
    return fs.dirname(api.nvim_buf_get_name(buf))
end

--- Find root directory with pattern in buffer.
---
--- @param buf buffer
--- @param pattern string|string[]
--- @return string
local function buf_find_root(buf, pattern)
    local root = fs.dirname(fs.find(pattern, { upward = true, path = buf_parent_dir(buf) })[1])
    assert(root ~= nil)
    return root
end

--- Get default LSP capabilities
---
--- @return lsp.ServerCapabilities
local function default_capabilities()
    return require('cmp_nvim_lsp').default_capabilities()
end

--- Convert list to a hash set.
---
--- @param list any[]
--- @return table<any, boolean>
local function list_to_set(list)
    local set = {}

    for _, item in pairs(list) do
        set[item] = true
    end

    return set
end

--- Evaluate configuration functions for the current buffer and retur a list of configuration dicts.
---
--- @param buf buffer
--- @return LspConfig[]
local function get_config_dicts(buf)
    return vim.tbl_map(function(config_fn)
        return config_fn(buf)
    end, M.filetype_lsp_configs[vim.bo[buf].filetype])
end

--- Filter configured clients by their name.
---
--- @param buf buffer
--- @param targets? LspConfigClientTarget[]
local function filter_configured_clients_by_name(buf, targets)
    local configs = get_config_dicts(buf)

    if targets == nil or next(targets) == nil then
        return configs
    end

    return vim.tbl_map(function(name) return configs[name] end, targets)
end

--- Filter active clients by their name or ID.
---
--- @param buf buffer
--- @param targets? LspClientTarget[]
local function filter_active_clients_by_name_or_id(buf, targets)
    local clients = lsp.get_clients({ bufnr = buf })

    if targets == nil or next(targets) == nil then
        return clients
    end

    --- @type table<LspClientTarget, true>
    local target_set = list_to_set(targets)

    return vim.tbl_filter(function(client)
        return target_set[client.name] or target_set[client.id]
    end, clients)
end

--- Completion function for configured LSP clients. Used for LspStart.
---
--- @param arg string
--- @return string[]
local function lsp_complete_configured_clients(arg)
    --- @type string[]
    local filetype_client_names = vim.tbl_keys(M.filetype_lsp_configs[vim.bo.filetype])

    return vim.tbl_filter(function(name)
        return vim.startswith(name, arg)
    end, filetype_client_names)
end

--- Completion function for active LSP clients. Used for LspStop and LspRestart.
---
--- @param arg string
--- @return string[]
local function lsp_complete_active_clients(arg)
    local clients = lsp.get_clients({ bufnr = 0 })
    local complete_items = {}

    for _, client in ipairs(clients) do
        -- Try to match name first. If name doesn't match, try to match ID.
        if vim.startswith(client.name, arg) then
            complete_items[#complete_items+1] = client.name
        elseif vim.startswith(tostring(client.id), arg) then
            complete_items[#complete_items+1] = tostring(client.id)
        end
    end

    return complete_items
end

--- Start configured LSP server(s) for buffer.
---
--- @param buf buffer
--- @param targets? LspClientTarget[]
function M.lsp_start(buf, targets)
    local configs = filter_configured_clients_by_name(buf, targets)
    vim.tbl_map(function(config) lsp.start(config, { bufnr = buf }) end, configs)
end

--- Stop LSP server(s) for buffer.
---
--- @param buf buffer
--- @param targets? LspClientTarget[]
--- @return lsp.Client[]
function M.lsp_stop(buf, targets)
    local clients = filter_active_clients_by_name_or_id(buf, targets)
    lsp.stop_client(clients, true)
    return clients
end

--- Restart LSP server(s) for buffer.
---
--- @param buf buffer
--- @param targets? LspClientTarget[]
function M.lsp_restart(buf, targets)
    local clients = M.lsp_stop(buf, targets)
    --- @type table<integer, table<buffer, true>>
    local client_attached_buffers = {}

    -- Wait for each client to stop, and then restart it and re-attach it to every buffer it was
    -- prevously attached to.
    for _, client in ipairs(clients) do
        client_attached_buffers[client.id] = client.attached_buffers

        -- Use a timer to periodically check if a client has been stopped, and then start the LSP
        -- client again for each buffer the client was previously attached to.
        local timer = vim.loop.new_timer()
        timer:start(500, 100, vim.schedule_wrap(function()
            if vim.lsp.client_is_stopped(client.id) then
                for attached_buf, _ in pairs(client_attached_buffers[client.id]) do
                    M.lsp_start(attached_buf, { client.name })
                end
            end
        end))
    end
end

--- Configure an LSP server.
---
--- Takes a single configuration dict. The following keys are required:
---   - name (string) : Name of the LSP serverlsp
---   - ftpattern (string | array[string]) : Filetype pattern(s) that trigger the LSP server
---   - cmd (array[string]) : Command used to launch the LSP server
---   - root_pattern (string | array[string]) : Patterns used to find the root_dir
---   - capabilities (table) (optional) : Capability overrides
---
--- All other provided keys are passed to vim.lsp.start()
---
--- @param config LspConfig
function M.configure_lsp(config)
    vim.validate({
        name = { config.name, 'string' },
        ftpattern = { config.ftpattern, { 'string', 'table' } },
        cmd = { config.cmd, 'table' },
        root_pattern = { config.root_pattern, { 'string', 'table' } },
        capabilities = { config.capabilities, 'table', true },
    })

    -- Set full config capabilities.
    config.capabilities = vim.tbl_extend('force', default_capabilities(), config.capabilities or {})

    -- Unset the config keys that won't be used by vim.lsp.start() and save them as local values.
    local ftpattern = config.ftpattern
    local root_pattern = config.root_pattern
    config.ftpattern = nil
    config.root_pattern = nil

    -- Convert ftpattern to table.
    if type(ftpattern) == 'string' then
        --- @cast ftpattern string[]
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
                desc = 'Autostart LSP clients',
                pattern = filetype,
                group = augroup,
                callback = function(opts)
                    M.lsp_start(opts.buf)
                end
            })
        end

        -- Add function to generate LSP configuration for the filetype to filetype_lsp_configs.
        local filetype_configs = M.filetype_lsp_configs[filetype]
        filetype_configs[config.name] = function(buf)
            return vim.tbl_extend('force', {
                root_dir = buf_find_root(buf, root_pattern),
            }, config)
        end
    end
end

-- Add LspStart, LspStop and LspRestart commands.
vim.api.nvim_create_user_command('LspStart', function(opts) M.lsp_start(0, opts.fargs) end, {
    desc = 'Start LSP servers for buffer',
    nargs = '*',
    complete = lsp_complete_configured_clients,
})

vim.api.nvim_create_user_command('LspStop', function(opts) M.lsp_stop(0, opts.fargs) end, {
    desc = 'Stop running LSP servers for buffer',
    nargs = '*',
    complete = lsp_complete_active_clients,
})

vim.api.nvim_create_user_command('LspRestart', function(opts) M.lsp_restart(0, opts.fargs) end, {
    desc = 'Restart running LSP servers for buffer',
    nargs = '*',
    complete = lsp_complete_active_clients,
})

return M
