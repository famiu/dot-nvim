local g = vim.g
local fn = vim.fn
local utils = require('utils')
local gen = require('statusline.generator')

require('statusline.statusline')

function _G.statusline()
    if g.statusline_winid == fn.win_getid() then
        return gen.generate_statusline(true)
    else
        return gen.generate_statusline(false)
    end
end

utils.set_opt('w', 'statusline', '%!v:lua.statusline()')
