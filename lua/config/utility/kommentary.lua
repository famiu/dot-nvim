local bind = vim.api.nvim_set_keymap
local config = require('kommentary.config')

config.configure_language("lua", {
    single_line_comment_string = '--',
    prefer_single_line_comments = true
})

bind('n', '<leader>cci', '<Plug>kommentary_line_increase', {})
bind('n', '<leader>ccd', '<Plug>kommentary_line_decrease', {})

bind('n', '<leader>ci', '<Plug>kommentary_motion_increase', {})
bind('n', '<leader>cd', '<Plug>kommentary_motion_decrease', {})

bind('v', '<leader>ci', '<Plug>kommentary_visual_increase', {})
bind('v', '<leader>cd', '<Plug>kommentary_visual_decrease', {})
