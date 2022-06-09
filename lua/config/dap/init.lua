local dap = require('dap')
local dapui = require('dapui')

-- Autocompletion
require('utils').create_augroup({
    {
        event = 'FileType',
        opts = {
            pattern = 'dap-repl',
            callback = function() require('dap.ext.autocompl').attach() end
        }
    }
}, 'dap')

-- Keymaps
vim.keymap.set('n', '<F5>', function() dap.continue() end, { silent = true })
vim.keymap.set('n', '<F6>', function() dap.step_back() end, { silent = true })
vim.keymap.set('n', '<F10>', function() dap.step_over() end, { silent = true })
vim.keymap.set('n', '<F11>', function() dap.step_into() end, { silent = true })
vim.keymap.set('n', '<F12>', function() dap.step_out() end, { silent = true })
vim.keymap.set(
    'n', '<Leader>b',
    function() dap.toggle_breakpoint() end,
    { silent = true }
)
vim.keymap.set(
    'n', '<Leader>B',
    function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
    { silent = true }
)
vim.keymap.set(
    'n', '<Leader>lp',
    function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
    { silent = true }
)
vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end, { silent = true })
vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end, { silent = true })

-- Dap UI
dapui.setup({
    icons = { expanded = '▾', collapsed = '▸' },
    mappings = {
        expand = { '<CR>', '<2-LeftMouse>' },
        open = 'o',
        remove = 'd',
        edit = 'e',
        repl = 'r',
        toggle = 't',
    },
    expand_lines = vim.fn.has('nvim-0.7'),
    sidebar = {
        elements = {
            { id = 'scopes', size = 0.25, },
            { id = 'breakpoints', size = 0.25 },
            { id = 'stacks', size = 0.25 },
            { id = 'watches', size = 00.25 },
        },
        size = 60,
        position = 'left',
    },
    tray = {
        elements = { 'repl', 'console' },
        size = 15,
        position = 'bottom',
    },
    floating = {
        max_height = nil,
        max_width = nil,
        border = 'single',
        mappings = {
            close = { 'q', '<Esc>' },
        },
    },
    windows = { indent = 1 },
    render = {
        max_type_length = nil,
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
require('nvim-dap-virtual-text').setup()

dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
    name = 'lldb'
}

-- Language configurations
dap.configurations.cpp = {
    {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
        runInTerminal = true,
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
