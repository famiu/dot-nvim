local bind = vim.api.nvim_set_keymap
local config = require('kommentary.config')
local wk = require('whichkey_setup')

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

wk.register_keymap('leader', {
    c = {
        name = '+comment',
        i = 'Increase commenting level for motion',
        d = 'Decrease commenting level for motion',
        c = {
            name = '+line',
            i = 'Increase commenting level for line',
            d = 'Decrease commenting level for line',
        }
    }
})

wk.register_keymap('visual', {
    c = {
        name = '+comment',
        i = 'Increase commenting level',
        d = 'Decrease commenting level'
    }
})
