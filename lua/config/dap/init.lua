local g = vim.g
local dap = require('dap')
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Enable DAP virtual text
g.dap_virtual_text = true

-- DAP REPL autocomplete
require('utils').create_augroup({
    {
        event = 'FileType',
        opts = {
            pattern = 'dap-repl',
            callback = require("dap.ext.autocompl").attach
        }
    }
}, 'dap_repl')

-- DAP Terminal settings
dap.defaults.fallback.external_terminal = {
    command = '/usr/bin/env';
    args = {'konsole', '-e'};
}

-- Load DAP UI
require("dapui").setup()

-- Utility functions used by mappings
function _G.nvim_dap_reload_continue()
    package.loaded['dap_config'] = nil
    require('dap_config')
    dap.continue()
end

-- DAP mappings
keymap.set('n', '<F5>', ':lua require("dap").continue()<CR>', opts)
keymap.set('n', '<S-F5>', ':lua nvim_dap_reload_continue()<CR>', opts)
keymap.set('n', '<F10>', ':lua require("dap").step_over()<CR>', opts)
keymap.set('n', '<F11>', ':lua require("dap").step_into()<CR>', opts)
keymap.set('n', '<F12>', ':lua require("dap").step_out()<CR>', opts)
keymap.set('n', '<M-b>', ':lua require("dap").toggle_breakpoint()<CR>', opts)
keymap.set(
    'n', '<M-B>',
    ':lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
    opts
)
keymap.set(
    'n', '<C-M-b>',
    ':lua require("dap").set_breakpoint' ..
    '(nil, nil, vim.fn.input("Log point message: "))<CR>', opts
)
keymap.set('v', '<M-k>', '<Cmd>lua require("dapui").eval()<CR>', opts)

-- Load DAP language configs
require('config.dap.langs')
