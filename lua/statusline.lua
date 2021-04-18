local components = require('feline.presets').default.components
local nvim_exec = vim.api.nvim_exec

-- Parse highlight of vertical split
local VertSplitHL = {
    fg = nvim_exec("highlight VertSplit", true):match("guifg=(#%d+)") or '#444444',
    bg = nvim_exec("highlight VertSplit", true):match("guibg=(#%d+)") or '#1E1E1E',
    style = nvim_exec("highlight VertSplit", true):match("gui=(#%d+)") or ''
}

-- Remove all inactive statusline components
components.left.inactive = {}
components.mid.inactive = {}
components.right.inactive = {}

-- Add strikethrough to vertical split highlight style
-- in order to have a thin line instead of the statusline
if VertSplitHL.style == '' then
    VertSplitHL.style = 'strikethrough'
else
    VertSplitHL.style = VertSplitHL.style .. ',strikethrough'
end

-- Apply the vertical split's highlight to the statusline
-- by having an empty provider with a highlight
components.left.inactive[1] = {
    provider = '',
    -- Make inactive statusline have the same highlight as vertical split
    hl = VertSplitHL
}

-- Setup feline.nvim
require('feline').setup()
