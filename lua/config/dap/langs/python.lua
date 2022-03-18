local bind = vim.api.nvim_buf_set_keymap
local opts = { noremap = true, silent = true }

require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')

local function dap_python_bindings()
    bind(0, 'n', '<LocalLeader>dm', ':lua require("dap-python").test_method()<CR>', opts)
    bind(0, 'n', '<LocalLeader>dc', ':lua require("dap-python").test_class()<CR>', opts)
    bind(0, 'v', '<LocalLeader>ds', '<ESC>:lua require("dap-python").debug_selection()<CR>', opts)
end

require('utils').create_augroup({
    {
        event = 'FileType',
        opts = {
            pattern = 'python',
            callback = dap_python_bindings
        }
    }
}, 'dap_python')
