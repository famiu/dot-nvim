local keymap = vim.keymap
local opts = { silent = true }

-- Map H and L to ^ and $
keymap.set('n', 'H', '^', {})
keymap.set('n', 'L', '$', {})

-- Don't leave visual mode after indenting
keymap.set('v', '>', '>gv^', {})
keymap.set('v', '<', '<gv^', {})

-- Indent with Tab and Shift-Tab
keymap.set('v', '<Tab>', '>', {})
keymap.set('v', '<S-Tab>', '<', {})

-- Apply the . command to all selected lines in visual mode
keymap.set('v', '.', ':normal .<CR>', opts)

-- Previous/next buffer
keymap.set('n', '[b', '<CMD>bprevious<CR>', opts)
keymap.set('n', ']b', '<CMD>bnext<CR>', opts)

-- Tab keybinds
-- Go to tab number
keymap.set('n', '<Leader>t1', '<CMD>tabnext1<CR>', opts)
keymap.set('n', '<Leader>t2', '<CMD>tabnext2<CR>', opts)
keymap.set('n', '<Leader>t3', '<CMD>tabnext3<CR>', opts)
keymap.set('n', '<Leader>t4', '<CMD>tabnext4<CR>', opts)
keymap.set('n', '<Leader>t5', '<CMD>tabnext5<CR>', opts)
keymap.set('n', '<Leader>t6', '<CMD>tabnext6<CR>', opts)
keymap.set('n', '<Leader>t7', '<CMD>tabnext7<CR>', opts)
keymap.set('n', '<Leader>t8', '<CMD>tabnext8<CR>', opts)
keymap.set('n', '<Leader>t9', '<CMD>tabnext9<CR>', opts)

-- Previous/next tab
keymap.set('n', '[t', '<CMD>tabprevious<CR>', opts)
keymap.set('n', ']t', '<CMD>tabnext<CR>', opts)

-- Move current tab
keymap.set('n', '[T', '<CMD>tabmove -1<CR>', opts)
keymap.set('n', ']T', '<CMD>tabmove +1<CR>', opts)

-- New tab
keymap.set('n', '<Leader>tn', '<CMD>tabnew<CR>', opts)

-- Close tab
keymap.set('n', '<Leader>tx', '<CMD>tabclose<CR>', opts)
keymap.set('n', '<Leader>tX', '<CMD>tabclose!<CR>', opts)

-- Open config
keymap.set('n', '<Leader>vc', '<CMD>edit $MYVIMRC<CR>', opts)
