-- DAP mapping
local bind = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

bind('n', '<F5>', ':lua require("dap").continue()<CR>', opts)
bind('n', '<S-F5>', ':lua require("config.dap.utils").reload_continue()<CR>', opts)
bind('n', '<F10>', ':lua require("dap").step_over()<CR>', opts)
bind('n', '<F11>', ':lua require("dap").step_into()<CR>', opts)
bind('n', '<F12>', ':lua require("dap").step_out()<CR>', opts)
bind('n', '<Leader>dt', ':lua require("dap").toggle_breakpoint()<CR>', opts)
bind('n', '<Leader>dbc',
    ':lua require("dap").set_breakpoint' ..
    '(vim.fn.input("Breakpoint condition: "))<CR>', opts)
bind('n', '<Leader>dbl',
    ':lua require("dap").set_breakpoint' ..
    '(nil, nil, vim.fn.input("Log point message: "))<CR>', opts)
bind('n', '<Leader>dro', ':lua require("dap").repl.open()<CR>', opts)
bind('n', '<Leader>drl', ':lua require("dap").run_last()<CR>', opts)


