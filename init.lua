-- Enable the experimental Lua module loader
vim.loader.enable()

local fn = vim.fn
local lazypath = fn.stdpath('data') .. '/lazy/lazy.nvim'
local os_utils = require('utilities.os')

local CheckConfigDeps
local LoadPlugins

-- Load settings and keybinds
require('settings')
require('keymaps')

--- Check if dependencies for Neovim config are installed before bootstrapping the config.
CheckConfigDeps = function()
    -- Ensure that the OS is Windows, Mac or Linux.
    if not os_utils.is_linux() and not os_utils.is_macos() and not os_utils.is_windows() then
        error('Neovim configuration does not support the OS ' .. vim.uv.os_uname().sysname)
    end

    local deps = {
        { exe = 'rg', reason = 'Telescope live grep' },
        { exe = 'fd', reason = 'Telescope find' },
    }

    if os_utils.is_linux() then
        local is_wayland = os.getenv('WAYLAND_DISPLAY') ~= nil
        local clipboard_handler = is_wayland and 'wl-copy' or 'xclip'

        table.insert(deps, { exe = clipboard_handler, reason = 'handling clipboard' })
        table.insert(deps, { exe = 'fswatch', reason = 'LSP watcher backend' })
    end

    local missing_deps = false

    for _, dep in ipairs(deps) do
        if fn.executable(dep.exe) == 0 then
            vim.notify('Missing ' .. dep.exe .. ' required for ' .. dep.reason, vim.log.levels.ERROR)
            missing_deps = true
        end
    end

    if missing_deps then
        error('Missing dependencies')
    end
end

LoadPlugins = function()
    vim.opt.rtp:prepend(lazypath)

    require('lazy').setup({ import = 'plugins' }, {
        dev = {
            path = vim.uv.os_homedir() .. '/Documents/Dev/neovim',
            fallback = true,
        },
        concurrency = require('utilities.os').pu_count(),
    })

    vim.keymap.set('n', '<Leader>z', '<CMD>Lazy<CR>')
end

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
