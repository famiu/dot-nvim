local exec = vim.api.nvim_exec

local components = require('feline.presets').default.components
local properties = require('feline.presets').default.properties

-- Force toggleterm to be inactive
table.insert(properties.force_inactive.filetypes, 'toggleterm')

-- Remove all inactive statusline components
components.left.inactive = {}
components.mid.inactive = {}
components.right.inactive = {}

-- Get highlight of inactive statusline by parsing the style, fg and bg of VertSplit
local InactiveStatusHL = {
    fg = exec("highlight VertSplit", true):match("guifg=(#%d+)") or '#444444',
    bg = exec("highlight VertSplit", true):match("guibg=(#%d+)") or '#1E1E1E',
    style = exec("highlight VertSplit", true):match("gui=(#%d+)") or ''
}

-- Add strikethrough to inactive statusline highlight style
-- in order to have a thin line instead of the statusline
if InactiveStatusHL.style == '' then
    InactiveStatusHL.style = 'strikethrough'
else
    InactiveStatusHL.style = InactiveStatusHL.style .. ',strikethrough'
end

-- Apply the highlight to the statusline
-- by having an empty provider with the highlight
components.left.inactive[1] = {
    provider = '',
    hl = InactiveStatusHL
}

-- Reset feline highlights
require('feline').reset_highlights()

-- Setup feline.nvim
require('feline').setup {
    colors = {
        fg = '#EAEAEA',
        bg = '#151515',
        white = '#FFFFFF',
        black = '#151515'
    }
}
