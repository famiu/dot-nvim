local M = {}
local fn = vim.fn
local cmd = vim.cmd
local types = {o = vim.o, b = vim.bo, w = vim.wo}
local buf_bind = vim.api.nvim_buf_set_keymap

local scan_dir = require('plenary.scandir').scan_dir

-- Unload all loaded modules
function M.unload_modules()
    -- Lua config prefix
    local config_prefix = fn.stdpath('config') .. '/lua'

    -- Search for all .lua files in config prefix
    local modules = scan_dir(
        config_prefix,
        { search_pattern = '.*%.lua$', hidden = true }
    )

    for i, module in ipairs(modules) do
        -- Remove config prefix and extension from module path
        module = string.match(module, string.format('%s/(.*)%%.lua', config_prefix))

        -- Changes slash in path to dot to follow lua module format
        module = string.gsub(module, "/", ".")

        -- If module ends with '.init', remove it.
        module = string.gsub(module, "%.init$", "")

        -- Override previous value with new value
        modules[i] = module
    end

    -- Extra modules outside the config to reload
    local modules_reload_extra = { 'packer' }

    for _, module in ipairs(modules_reload_extra) do
        table.insert(modules, module)
    end

    -- Reload each module in the modules table
    for _, module in ipairs(modules) do
        package.loaded[module] = nil
    end
end

-- Reload all start plugins
function M.reload_start_plugins()
    -- Find all start plugin files
    local loadfiles = scan_dir(
        fn.stdpath('data') .. '/site/pack',
        { search_pattern = '.*/start/.*/plugin/.*%.n?vim$', hidden = true }
    )

    -- Source every file found
    for _, file in ipairs(loadfiles) do
        cmd('source ' .. file)
    end
end

-- Reload Vim configuration
function M.Reload()
    -- Stop LSP
    cmd('LspStop')

    -- Unload all already loaded modules
    M.unload_modules()

    -- Source init.lua
    cmd('luafile $MYVIMRC')

    -- Reload start plugins
    M.reload_start_plugins()
end

-- Restart Vim without having to close and run again
function M.Restart()
    -- Reload config
    M.Reload()

    -- Manually run VimEnter autocmd to emulate a new run of Vim
    cmd('doautocmd VimEnter')
end

-- Get option
function M.get_opt(type, name)
    return types[type][name]
end

-- Set option
function M.set_opt(type, name, value)
    types[type][name] = value

    if type ~= 'o' then
        types['o'][name] = value
    end
end

-- Append option to a list of options
function M.append_opt(type, name, value)
    local current_value = M.get_opt(type, name)

    if not string.match(current_value, value) then
        M.set_opt(type, name, current_value .. value)
    end
end

-- Remove option from a list of options
function M.remove_opt(type, name, value)
    local current_value = M.get_opt(type, name)

    if string.match(current_value, value) then
        M.set_opt(type, name, string.gsub(current_value, value, ""))
    end
end

-- Create an augroup
function M.create_augroup(autocmds, name)
    cmd('augroup ' .. name)
    cmd('autocmd!')

    for _, autocmd in ipairs(autocmds) do
        cmd('autocmd ' .. table.concat(autocmd, ' '))
    end

    cmd('augroup END')
end

-- Make navigation keys navigate through display lines instead of physical lines
function M.set_buffer_soft_line_nagivation()
    local opts = { noremap = true, silent = true }

    buf_bind(0, 'n', 'k', 'gk', opts)
    buf_bind(0, 'n', 'j', 'gj', opts)
    buf_bind(0, 'n', '0', 'g0', opts)
    buf_bind(0, 'n', '^', 'g^', opts)
    buf_bind(0, 'n', '$', 'g$', opts)

    buf_bind(0, 'n', '<Up>', 'gk', opts)
    buf_bind(0, 'n', '<Down>', 'gj', opts)
    buf_bind(0, 'n', '<Home>', 'g<Home>', opts)
    buf_bind(0, 'n', '<End>', 'g<End>', opts)

    buf_bind(0, 'o', 'k', 'gk', opts)
    buf_bind(0, 'o', 'j', 'gj', opts)
    buf_bind(0, 'o', '0', 'g0', opts)
    buf_bind(0, 'o', '^', 'g^', opts)
    buf_bind(0, 'o', '$', 'g$', opts)

    buf_bind(0, 'o', '<Up>', 'gk', opts)
    buf_bind(0, 'o', '<Down>', 'gj', opts)
    buf_bind(0, 'o', '<Home>', 'g<Home>', opts)
    buf_bind(0, 'o', '<End>', 'g<End>', opts)

    buf_bind(0, 'i', '<Up>', '<C-o>gk', opts)
    buf_bind(0, 'i', '<Down>', '<C-o>gj', opts)
    buf_bind(0, 'i', '<Home>', '<C-o>g<Home>', opts)
    buf_bind(0, 'i', '<End>', '<C-o>g<End>', opts)
end

return M
