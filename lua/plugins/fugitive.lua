local keymap = vim.keymap

keymap.set('n', '<Space>gb', ':Git blame<CR>', {})
keymap.set('n', '<Space>gs', ':Git<CR>', {})
keymap.set('n', '<Space>gc', ':Git commit -v<CR>', {})
keymap.set('n', '<Space>ga', ':Git add -p<CR>', {})
keymap.set('n', '<Space>gm', ':Git commit --amend<CR>', {})
keymap.set('n', '<Space>gp', ':Git push<CR>', {})
keymap.set('n', '<Space>gf', ':Git fetch<CR>', {})
keymap.set('n', '<Space>gF', ':Git pull<CR>', {})
keymap.set('n', '<Space>gR', ':Git pull --rebase<CR>', {})
keymap.set('n', '<Space>gd', ':Gdiff<CR>', {})
keymap.set('n', '<Space>gw', ':Gwrite<CR>', {})
