local bind = vim.api.nvim_set_keymap
local g = vim.g

g.gitgutter_sign_priority = 10
g.gitgutter_preview_win_floating = 1
g.gitgutter_set_sign_backgrounds = 1

vim.api.nvim_exec([[
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1
]], false)

bind('n', ']h', '<Plug>(GitGutterNextHunk)', {})
bind('n', '[h', '<Plug>(GitGutterPrevHunk)', {})

bind('n', 'ghs', '<Plug>(GitGutterStageHunk)', {})
bind('n', 'ghu', '<Plug>(GitGutterUndoHunk)', {})
bind('n', 'ghp', '<Plug>(GitGutterPreviewHunk)', {})
