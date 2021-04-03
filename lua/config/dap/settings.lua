local g = vim.g
local dap = require('dap')

-- Enable DAP virtual text
g.dap_virtual_text = true

-- DAP REPL autocomplete
require('utils').create_augroup({
    {'FileType', 'dap-repl', 'lua require("dap.ext.autocompl").attach()'}
}, 'dap_repl')

-- DAP Terminal settings
dap.defaults.fallback.external_terminal = {
    command = '/usr/bin/env';
    args = {'konsole', '-e'};
}
