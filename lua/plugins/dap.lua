local api = vim.api
local fn = vim.fn
local keymap = vim.keymap
local augroup = api.nvim_create_augroup('dap-settings', {})

local M = {
    'mfussenegger/nvim-dap',
    dependencies = {
        'rcarriga/nvim-dap-ui',
        'theHamsta/nvim-dap-virtual-text'
    }
}

function M.init()
    -- Keybindings
    keymap.set('n', '<F5>', function() require('dap').continue() end, { silent = true })
    keymap.set('n', '<F6>', function() require('dap').step_back() end, { silent = true })
    keymap.set('n', '<F10>', function() require('dap').step_over() end, { silent = true })
    keymap.set('n', '<F11>', function() require('dap').step_into() end, { silent = true })
    keymap.set('n', '<F12>', function() require('dap').step_out() end, { silent = true })
    keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end,
        { silent = true })
    keymap.set('n', '<Leader>B',
        function() require('dap').set_breakpoint(fn.input('Breakpoint condition: ')) end,
        { silent = true })
    keymap.set('n', '<Leader>lp',
        function()
            require('dap').set_breakpoint(nil, nil, fn.input('Log point message: '))
        end,
        { silent = true })
    keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end, { silent = true })
    keymap.set('n', '<Leader>dl', function() require('dap').run_last() end, { silent = true })
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

    -- Dap UI
    dapui.setup({
        controls = {
            element = 'repl',
            enabled = true,
            icons = {
                disconnect = '',
                pause = '',
                play = '',
                run_last = '',
                step_back = '',
                step_into = '',
                step_out = '',
                step_over = '',
                terminate = ''
            }
        },
        element_mappings = {},
        expand_lines = true,
        floating = {
            border = 'single',
            mappings = {
                close = { 'q', '<Esc>' }
            }
        },
        force_buffers = true,
        icons = {
            collapsed = '',
            current_frame = '',
            expanded = ''
        },
        layouts = { {
            elements = { {
                id = 'scopes',
                size = 0.25
            }, {
                id = 'breakpoints',
                size = 0.25
            }, {
                id = 'stacks',
                size = 0.25
            }, {
                id = 'watches',
                size = 0.25
            } },
            position = 'left',
            size = 40
        }, {
            elements = { {
                id = 'repl',
                size = 0.5
            }, {
                id = 'console',
                size = 0.5
            } },
            position = 'bottom',
            size = 10
        } },
        mappings = {
            edit = 'e',
            expand = { '<CR>', '<2-LeftMouse>' },
            open = 'o',
            remove = 'd',
            repl = 'r',
            toggle = 't'
        },
        render = {
            indent = 1,
            max_value_lines = 100
        }
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
