local bind = vim.api.nvim_set_keymap

bind('n', '<Space>gb', ':Gblame<CR>', {})
bind('n', '<Space>gs', ':Gstatus<CR>', {})
bind('n', '<Space>gc', ':Git commit -v<CR>', {})
bind('n', '<Space>ga', ':Git add -p<CR>', {})
bind('n', '<Space>gm', ':Git commit --amend<CR>', {})
bind('n', '<Space>gp', ':Git push<CR>', {})
bind('n', '<Space>gd', ':Gdiff<CR>', {})
bind('n', '<Space>gw', ':Gwrite<CR>', {})
bind('n', '<Space>gv', ':GV<CR>', {})
bind('n', '<Space>g!', ':GV!<CR>', {})
bind('n', '<Space>g?', ':GV?<CR>', {})
