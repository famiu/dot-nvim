local api = vim.api
local cmd = vim.cmd
local fn = vim.fn
local loop = vim.loop
local lazypath = fn.stdpath('data') .. '/lazy/lazy.nvim'

-- Get number of processing units to use for configuring concurrent stuff
PU_COUNT = #loop.cpu_info()

local InstallConfigDeps
local LoadPlugins

local function BootstrapConfig()
    -- Basic option configurations and similar settings
    require('settings')
    -- Basic keybinds
    require('keybinds')

    -- Use Ansible to install dependencies for the Neovim configuration if needed
    if not loop.fs_stat(lazypath) then
        InstallConfigDeps()

        api.nvim_create_autocmd('User', {
            once = true,
            pattern = 'AnsibleDone',
            desc = 'Load plugins after installing config dependencies',
            callback = function(_)
                -- Clone lazy.nvim
                fn.system({
                    'git',
                    'clone',
                    '--filter=blob:none',
                    'https://github.com/folke/lazy.nvim.git',
                    '--branch=stable',
                    lazypath,
                })

                LoadPlugins()
            end
        })
    else
        LoadPlugins()
    end
end

InstallConfigDeps = function()
    if fn.executable('ansible-playbook') == 0 then
        api.nvim_err_writeln('ansible-playbook not found. Cannot install config dependencies')
        return
    end

    vim.notify('Installing config dependencies using Ansible', vim.log.levels.INFO)

    -- Make sure current window is the only window
    if #api.nvim_list_wins() > 1 then
        cmd.wincmd('o')
    end

    -- Open Ansible in current window
    cmd.terminal(
        string.format('/usr/bin/env ansible-playbook -K %s/deps.yml', fn.stdpath('config'))
    )

    api.nvim_create_autocmd('TermClose', {
        once = true,
        desc = 'Automatically close Ansible terminal',
        callback = function(opts)
            if vim.v.event.status ~= 0 then
                api.nvim_err_writeln("Error while installing config dependencies")
                return
            end

            api.nvim_buf_delete(opts.buf, { force = true })
            api.nvim_exec_autocmds('User', { pattern = 'AnsibleDone' })
        end
    })
end

LoadPlugins = function()
    vim.opt.rtp:prepend(lazypath)

    require('lazy').setup({ import = 'plugins' }, {
        dev = {
            path = '~/Workspace/neovim'
        },
        concurrency = PU_COUNT,
    })

    -- LSP
    require('lsp')
    -- Other utilities
    require('utilities')
end

BootstrapConfig()
-- Command to update config dependencies
api.nvim_create_user_command('UpdateConfigDeps', InstallConfigDeps, {})
