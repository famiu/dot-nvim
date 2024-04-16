local api = vim.api
local fn = vim.fn

local function dapconfig()
    local dap = require('dap')
    local dapui = require('dapui')

    -- DAP signs
    fn.sign_define('DapBreakpoint', { text = '󰏃', texthl = '', linehl = '', numhl = '' })
    fn.sign_define('DapBreakpointCondition', { text = '', texthl = '', linehl = '', numhl = '' })
    fn.sign_define('DapLogPoint', { text = '', texthl = '', linehl = '', numhl = '' })
    fn.sign_define('DapStopped', { text = '→', texthl = '', linehl = '', numhl = '' })
    fn.sign_define('DapBreakpointRejected', { text = '', texthl = '', linehl = '', numhl = '' })

    -- DAP autocompletion
    api.nvim_create_autocmd('FileType', {
        pattern = 'dap-repl',
        callback = function()
            require('dap.ext.autocompl').attach()
        end,
        group = api.nvim_create_augroup('dap-settings', {}),
        desc = 'DAP Autocompletion',
    })

    -- DAP UI
    dapui.setup()

    dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
    end

    -- DAP Virtual Text
    require('nvim-dap-virtual-text').setup({})

    -- Adapters
    dap.adapters.lldb = {
        type = 'executable',
        command = vim.fn.exepath('lldb-vscode'),
        name = 'lldb',
    }

    local c_cpp_rust_base_config = {
        {
            name = 'Launch',
            type = 'lldb',
            request = 'launch',
            program = function()
                return fn.input('Path to executable: ', fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
            args = {},
            runInTerminal = false,
        },
        {
            name = 'Attach to process',
            type = 'lldb',
            request = 'attach',
            pid = require('dap.utils').pick_process,
            args = {},
        },
    }

    -- External Terminal
    dap.defaults.fallback.force_external_terminal = true
    dap.defaults.fallback.external_terminal = {
        -- Use Windows Terminal for Windows, and Kitty for Linux.
        command = require('utilities.os').is_windows() and 'wt' or 'kitty',
        args = { '--' },
    }

    -- Language configurations
    dap.configurations.cpp = c_cpp_rust_base_config
    dap.configurations.c = c_cpp_rust_base_config
    dap.configurations.rust = c_cpp_rust_base_config

    -- Program specific configs
    table.insert(
        dap.configurations.c,
        setmetatable({
            name = 'Neovim',
            type = 'lldb',
            request = 'launch',
            program = vim.uv.os_homedir() .. '/dev/neovim/neovim/build/bin/nvim',
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
            args = function()
                return vim.split(fn.input('Args: ', '--clean '), ' ')
            end,
            runInTerminal = true,
        }, {
            __call = function(config)
                -- Listeners are indexed by a key.
                -- This is like a namespace and must not conflict with what plugins
                -- like nvim-dap-ui or nvim-dap itself uses.
                -- It's best to not use anything starting with `dap`
                local key = 'neovim-debug-auto-attach'

                -- dap.listeners.<before | after>.<event_or_command>.<plugin_key>`
                -- We listen to the `initialize` response. It indicates a new session got initialized
                dap.listeners.after.initialize[key] = function(session)
                    -- Immediately clear the listener, we don't want to run this logic for additional sessions
                    dap.listeners.after.initialize[key] = nil

                    -- The first argument to a event or response is always the session
                    -- A session contains a `on_close` table that allows us to register functions
                    -- that get called when the session closes.
                    -- We use this to ensure the listeners get cleaned up
                    session.on_close[key] = function()
                        for _, handler in pairs(dap.listeners.after) do
                            handler[key] = nil
                        end
                    end
                end

                -- We listen to `event_process` to get the pid:
                dap.listeners.after.event_process[key] = function(_, body)
                    -- Immediately clear the listener, we don't want to run this logic for additional sessions
                    dap.listeners.after.event_process[key] = nil

                    local ppid = body.systemProcessId
                    -- The pid is the parent pid, we need to attach to the child. This uses the `ps` tool to get it
                    -- It takes a bit for the child to arrive. This uses the `vim.wait` function to wait up to a second
                    -- to get the child pid.
                    vim.wait(1000, function()
                        return tonumber(vim.fn.system('ps -o pid= --ppid ' .. tostring(ppid))) ~= nil
                    end)
                    local pid = tonumber(vim.fn.system('ps -o pid= --ppid ' .. tostring(ppid)))
                    local home = vim.uv.os_homedir()

                    -- If we found it, spawn another debug session that attaches to the pid.
                    if pid then
                        dap.run({
                            name = 'Neovim embedded',
                            type = 'lldb',
                            request = 'attach',
                            pid = pid,
                            -- ⬇️ Change paths as needed
                            program = home .. '/dev/neovim/neovim/build/bin/nvim',
                            env = { 'VIMRUNTIME=' .. home .. '/dev/neovim/neovim/runtime' },
                            cwd = home .. '/dev/neovim/neovim/',
                            externalConsole = false,
                        })
                    end
                end
                return config
            end,
        })
    )
end

local M = {
    {
        'mfussenegger/nvim-dap',
        dependencies = { 'williamboman/mason.nvim' },
        keys = {
            {
                '<F5>',
                function()
                    require('dap').continue()
                end,
            },
            {
                '<F6>',
                function()
                    require('dap').step_back()
                end,
            },
            {
                '<S-F10>',
                function()
                    require('dap').step_over()
                end,
            },
            {
                '<S-F11>',
                function()
                    require('dap').step_into()
                end,
            },
            {
                '<S-F12>',
                function()
                    require('dap').step_out()
                end,
            },
            {
                '<Leader>b',
                function()
                    require('dap').toggle_breakpoint()
                end,
            },
            {
                '<Leader>B',
                function()
                    require('dap').set_breakpoint(fn.input('Breakpoint condition: '))
                end,
            },
            {
                '<Leader>lp',
                function()
                    require('dap').set_breakpoint(nil, nil, fn.input('Log point message: '))
                end,
            },
            {
                '<Leader>cb',
                function()
                    require('dap').clear_breakpoints()
                end,
            },
            {
                '<Leader>dr',
                function()
                    require('dap').repl.open()
                end,
            },
            {
                '<Leader>dl',
                function()
                    require('dap').run_last()
                end,
            },
        },
        config = dapconfig,
    },
    {
        'rcarriga/nvim-dap-ui',
        lazy = true,
        dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    },
    { 'theHamsta/nvim-dap-virtual-text', lazy = true, dependencies = { 'mfussenegger/nvim-dap' } },
}

return M
