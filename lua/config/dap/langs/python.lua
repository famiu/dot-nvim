local keymap = vim.keymap
local opts = { noremap = true, silent = true, buffer = 0 }

require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')

local function dap_python_bindings()
    keymap.set('n', '<LocalLeader>dm', ':lua require("dap-python").test_method()<CR>', opts)
    keymap.set('n', '<LocalLeader>dc', ':lua require("dap-python").test_class()<CR>', opts)
    keymap.set('v', '<LocalLeader>ds', '<ESC>:lua require("dap-python").debug_selection()<CR>', opts)
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
