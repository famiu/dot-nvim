local bind = vim.api.nvim_set_keymap

-- Make Y key yank to end of line
bind('n', 'Y', 'y$', { noremap = true })

-- Make U redo
bind('n', 'U', 'undo', { noremap = true })

-- Don't leave visual mode after indenting
bind('v', '>', '>gv^', { noremap = true })
bind('v', '<', '<gv^', { noremap = true })

-- Indent with Tab and Shift-Tab
bind('v', '<Tab>', '>', {})
bind('v', '<S-Tab>', '<', {})

