local keymap = vim.keymap
local config = require('kommentary.config')

config.configure_language("lua", {
    single_line_comment_string = '--',
    prefer_single_line_comments = true
})

keymap.set('n', '<leader>cci', '<Plug>kommentary_line_increase', {})
keymap.set('n', '<leader>ccd', '<Plug>kommentary_line_decrease', {})

keymap.set('n', '<leader>ci', '<Plug>kommentary_motion_increase', {})
keymap.set('n', '<leader>cd', '<Plug>kommentary_motion_decrease', {})

keymap.set('v', '<leader>ci', '<Plug>kommentary_visual_increase', {})
keymap.set('v', '<leader>cd', '<Plug>kommentary_visual_decrease', {})
