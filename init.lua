-- Enable the experimental Lua module loader
vim.loader.enable()

local fn = vim.fn
local os_utils = require('utilities.os')

-- Load settings and keybinds
require('settings')
require('keymaps')

--- Check if dependencies for Neovim config are installed before bootstrapping the config.
local function CheckConfigDeps()
    -- Ensure that the OS is Windows, Mac or Linux.
    if not os_utils.is_linux() and not os_utils.is_macos() and not os_utils.is_windows() then
        error('Neovim configuration does not support the OS ' .. vim.uv.os_uname().sysname)
    end

    local deps = {
        { exe = 'rg', reason = 'Live grep' },
        { exe = 'fd', reason = 'File search' },
        { exe = 'fzf', reason = 'Fuzzy finder' },
        { exe = 'node', reason = 'Tree-sitter and LSP' },
        { exe = 'git', reason = 'Plugin management' },
    }

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

-- Check to see if config dependencies are found.
CheckConfigDeps()

-- Install and configure plugins with vim.pack.
require('plugins')
