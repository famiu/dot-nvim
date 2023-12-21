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
    -- Don't prompt to bootstrap the config if a file argument is passed
    if #fn.argv() ~= 0 then
        return
    end

    local choice = fn.confirm('Bootstrap config?', '&Yes\n&No', 2, 'Q')
    if choice == 2 then
        return
    end

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
end

InstallConfigDeps = function()
    if fn.executable('ansible-playbook') == 0 then
        vim.notify(
            'ansible-playbook not found. Cannot install config dependencies',
            vim.log.levels.ERROR
        )
        return
    end

    vim.notify('Installing config dependencies using Ansible', vim.log.levels.INFO)

    -- Open float window for Ansible
    local float_scale = 0.6
    local float_win = api.nvim_open_win(api.nvim_create_buf(true, false), true, {
        relative = 'editor',
        height = math.floor(vim.o.lines * float_scale + 0.5),
        width = math.floor(vim.o.columns * float_scale + 0.5),
        row = math.floor(vim.o.lines * (1 - float_scale) / 2 + 0.5),
        col = math.floor(vim.o.columns * (1 - float_scale) / 2 + 0.5),
        zindex = 1000,
        style = 'minimal',
        border = 'single',
        title = 'Config dependency installer',
        title_pos = 'center'
    })

    -- If this function is being run before VimEnter, then the float window is going to lose focus.
    -- To prevent that, refocus the window on VimEnter.
    if vim.v.vim_did_enter == 0 then
        api.nvim_create_autocmd('VimEnter', {
            once = true,
            desc = 'Focus Ansible window',
            callback = function(_)
                api.nvim_set_current_win(float_win)
            end
        })
    end

    -- Open Ansible in float window
    fn.termopen(string.format('/usr/bin/env ansible-playbook -K %s/deps.yml', fn.stdpath('config')))
    cmd.startinsert()

    api.nvim_create_autocmd('TermClose', {
        once = true,
        desc = 'Automatically close Ansible terminal',
        callback = function(opts)
            if vim.v.event.status ~= 0 then
                vim.notify('Error while installing config dependencies', vim.log.levels.ERROR)
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
            path = '~/dev/neovim'
        },
        concurrency = PU_COUNT,
    })

    -- LSP
    require('lsp')
    -- Other utilities
    require('utilities')
end

-- Basic option configurations and similar settings
require('settings')

-- If using a GUI, load GUI settings.
if vim.fn.has('gui_running') == 1 then
    require('gui_settings')
end

-- Basic keybinds
require('keybinds')

-- Use Ansible to install dependencies for the Neovim configuration if needed
-- Otherwise, just load plugins
if not loop.fs_stat(lazypath) then
    BootstrapConfig()
else
    LoadPlugins()
end

-- Command to update config dependencies
api.nvim_create_user_command('UpdateConfigDeps', InstallConfigDeps, {})
