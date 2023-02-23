local api = vim.api
local fn = vim.fn
local keymap = vim.keymap
local augroup = api.nvim_create_augroup('dap-settings', {})

local M = {
    'mfussenegger/nvim-dap',
    lazy = true,
    dependencies = {
        'rcarriga/nvim-dap-ui',
        'theHamsta/nvim-dap-virtual-text'
    }
}

function M.init()
    -- Keybindings
    keymap.set('n', '<F5>', function() require('dap').continue() end)
    keymap.set('n', '<F6>', function() require('dap').step_back() end)
    keymap.set('n', '<F10>', function() require('dap').step_over() end)
    keymap.set('n', '<F11>', function() require('dap').step_into() end)
    keymap.set('n', '<F12>', function() require('dap').step_out() end)
    keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
    keymap.set(
        'n', '<Leader>B',
        function() require('dap').set_breakpoint(fn.input('Breakpoint condition: ')) end
    )
    keymap.set(
        'n', '<Leader>lp',
        function() require('dap').set_breakpoint(nil, nil, fn.input('Log point message: ')) end
    )
    keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
    keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
end

function M.config()
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
        callback = function() require('dap.ext.autocompl').attach() end,
        desc = 'DAP Autocompletion',
        group = augroup
    })

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
    require('nvim-dap-virtual-text').setup {}

    dap.adapters.lldb = {
        type = 'executable',
        command = vim.trim(fn.system({ '/usr/bin/which', 'lldb-vscode ' })),
        name = 'lldb'
    }

    -- Language configurations
    dap.configurations.cpp = {
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

    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp
end

return M
