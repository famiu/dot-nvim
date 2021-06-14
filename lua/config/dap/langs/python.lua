local M = {}

local bind = vim.api.nvim_buf_set_keymap
local opts = { noremap = true, silent = true }
local bufnr = vim.api.nvim_get_current_buf()

require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')

function M.dap_python_bindings()
    bind(0, 'n', '<LocalLeader>dm', ':lua require("dap-python").test_method()<CR>', opts)
    bind(0, 'n', '<LocalLeader>dc', ':lua require("dap-python").test_class()<CR>', opts)
    bind(0, 'v', '<LocalLeader>ds', '<ESC>:lua require("dap-python").debug_selection()<CR>', opts)

    local keys = {
        d = {
            name = '+dap',
            m = 'Test method',
            c = 'Test class',
        }
    }

    local visual_keys = {
        d = {
            name = '+dap',
            s = 'Debug selection'
        }
    }

    require('which-key').register(keys, {
        prefix = "<localleader>",
        buffer = bufnr
    })
    require('which-key').register(visual_keys, {
        prefix = "<localleader>",
        mode = "v",
        buffer = bufnr
    })
end

require('utils').create_augroup({
    {'FileType', 'python', 'lua require("config.dap.langs.python").dap_python_bindings()'}
}, 'dap_python')

return M
