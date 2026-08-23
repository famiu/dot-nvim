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

    dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
    end

    -- Adapters
    dap.adapters.lldb = {
        type = 'executable',
        command = vim.fn.exepath('lldb-dap'),
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

    local terminals = {
        { 'ghostty', '-e' },
        { 'kitty', '--single-instance', '-e' },
        { 'konsole', '-e' },
        { 'gnome-terminal', '--' },
        { 'wt', '--' },
    }

    -- Check if an external terminal is available, and use it if it is.
    for _, terminal_info in ipairs(terminals) do
        if vim.fn.executable(terminal_info[1]) then
            -- External Terminal
            dap.defaults.fallback.force_external_terminal = true
            dap.defaults.fallback.external_terminal = {
                command = terminal_info[1],
                args = { terminal_info[2] },
            }

            break
        end
    end

    -- Language configurations
    dap.configurations.cpp = c_cpp_rust_base_config
    dap.configurations.c = c_cpp_rust_base_config
    dap.configurations.rust = c_cpp_rust_base_config
end

require('dapui').setup({})
require('nvim-dap-virtual-text').setup({})
dapconfig()

vim.keymap.set('n', '<F5>', function()
    require('dap').continue()
end, { desc = 'DAP: Continue' })
vim.keymap.set('n', '<F6>', function()
    require('dap').step_back()
end, { desc = 'DAP: Step back' })
vim.keymap.set('n', '<F10>', function()
    require('dap').step_over()
end, { desc = 'DAP: Step Over' })
vim.keymap.set('n', '<F11>', function()
    require('dap').step_into()
end, { desc = 'DAP: Step Into' })
vim.keymap.set('n', '<F12>', function()
    require('dap').step_out()
end, { desc = 'DAP: Step Out' })
vim.keymap.set('n', '<S-F5>', function()
    require('dap').terminate()
end, { desc = 'DAP: Terminate' })
vim.keymap.set('n', '<Leader>b', function()
    require('dap').toggle_breakpoint()
end, { desc = 'DAP: Toggle Breakpoint' })
vim.keymap.set('n', '<Leader>B', function()
    require('dap').set_breakpoint(fn.input('Breakpoint condition: '))
end, { desc = 'DAP: Conditional breakpoint' })
vim.keymap.set('n', '<Leader>dp', function()
    require('dap').set_breakpoint(nil, nil, fn.input('Log point message: '))
end, { desc = 'DAP: Log point' })
vim.keymap.set('n', '<Leader>dc', function()
    require('dap').clear_breakpoints()
end, { desc = 'DAP: Clear breakpoints' })
vim.keymap.set('n', '<Leader>dr', function()
    require('dap').repl.toggle()
end, { desc = 'DAP: Toggle REPL' })
vim.keymap.set('n', '<Leader>dl', function()
    require('dap').run_last()
end, { desc = 'DAP: Run last' })
