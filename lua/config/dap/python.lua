local M = {}

local bind = vim.api.nvim_buf_set_keymap
local opts = { noremap = true, silent = true }

require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')

function M.dap_python_bindings()
    bind(0, 'n', '<leader>dlm', ':lua require("dap-python").test_method()<CR>', opts)
    bind(0, 'n', '<leader>dlc', ':lua require("dap-python").test_class()<CR>', opts)
    bind(0, 'v', '<leader>dls', '<ESC>:lua require("dap-python").debug_selection()<CR>', opts)
end

require('utils').create_augroup({
    {'FileType', 'python', 'lua require("config.dap.python").dap_python_bindings()'}
}, 'dap_python')

return M
