local M = {}
local dap =  require'dap'

function M.reload_continue()
    package.loaded['dap_config'] = nil
    require('dap_config')
    dap.continue()
end

return M
