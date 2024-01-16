local fn = vim.fn
local lazypath = fn.stdpath('data') .. '/lazy/lazy.nvim'
local os_utils = require('utilities.os')

local CheckConfigDeps
local LoadPlugins

--- Check if dependencies for Neovim config are installed before bootstrapping the config.
CheckConfigDeps = function()
    -- Ensure that the OS is Windows, Mac or Linux.
    if not os_utils.is_posix() and not os_utils.is_windows() then
        error('Neovim configuration does not support the OS ' .. vim.uv.os_uname().sysname)
    end

    local deps = {
        { exe = 'rg', reason = 'Telescope live grep' },
        { exe = 'fd', reason = 'Telescope find' },
    }

    if os_utils.is_linux() then
        local is_wayland = os.getenv('WAYLAND_DISPLAY') ~= nil
        local clipboard_handler = is_wayland and 'wl-clipboard' or 'xclip'

        table.insert(deps, { exe = clipboard_handler, reason = 'handling clipboard' })
    end

    for _, dep in ipairs(deps) do
        if fn.executable(dep.exe) == 0 then
            error(('%s required for %s'):format(dep.exe, dep.reason))
        end
    end
end

LoadPlugins = function()
    vim.opt.rtp:prepend(lazypath)

    require('lazy').setup({ import = 'plugins' }, {
        dev = {
            path = vim.uv.os_homedir() .. '/dev/neovim',
        },
        concurrency = require('utilities.os').pu_count(),
    })

    -- LSP
    require('lsp')
    -- Other utilities
    require('utilities')
end

-- Basic option configurations and similar settings.
require('settings')

-- If using a GUI, load GUI settings.
if fn.has('gui_running') == 1 then
    require('gui_settings')
end

-- Basic keybinds
require('keybinds')

-- Check to see if config dependencies are found.
CheckConfigDeps()

-- Bootstrap lazy.nvim if required.
if not vim.uv.fs_stat(lazypath) then
    fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end

LoadPlugins()
