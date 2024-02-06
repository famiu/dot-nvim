local keymap = vim.keymap
local tabline_utils = require('utilities.tabline')

-- Map H and L to ^ and $
keymap.set('n', 'H', '^')
keymap.set('n', 'L', '$')

-- Make J and K move selected lines up and down
keymap.set('v', 'J', [[:move '>+1<CR>gv=gv]], { silent = true })
keymap.set('v', 'K', [[:move '<-2<CR>gv=gv]], { silent = true })

-- Don't move cursor when using J to join lines
keymap.set('n', 'J', 'mzJ`z')

-- Make certain motions keep cursor in the middle
keymap.set('n', '<C-u>', '<C-u>zz')
keymap.set('n', '<C-d>', '<C-d>zz')
keymap.set('n', 'n', 'nzz')
keymap.set('n', 'N', 'Nzz')

-- Don't leave visual mode after indenting
keymap.set('v', '>', '>gv^')
keymap.set('v', '<', '<gv^')

-- Apply the . command to all selected lines in visual mode
keymap.set('v', '.', ':normal .<CR>', { silent = true })

-- Cycle through windows
keymap.set('n', '[w', '<CMD>wincmd W<CR>')
keymap.set('n', ']w', '<CMD>wincmd w<CR>')

-- Tab keybinds
-- Previous/next tab
keymap.set('n', '[t', '<CMD>tabprevious<CR>')
keymap.set('n', ']t', '<CMD>tabnext<CR>')

-- Move current tab
keymap.set('n', '[T', '<CMD>tabmove -1<CR>')
keymap.set('n', ']T', '<CMD>tabmove +1<CR>')

-- New tab
keymap.set('n', '<Leader>tn', '<CMD>tabnew<CR>')

-- Close tab
keymap.set('n', '<Leader>tx', '<CMD>tabclose<CR>')
keymap.set('n', '<Leader>tX', '<CMD>tabclose!<CR>')

-- Buffer keybinds
-- Previous/next buffer
keymap.set('n', '[b', function() tabline_utils.tabline_buffer_advance(-vim.v.count1) end)
keymap.set('n', ']b', function() tabline_utils.tabline_buffer_advance(vim.v.count1) end)

-- Go to n-th buffer in tabline
keymap.set('n', '<Leader>tt', function() tabline_utils.tabline_buffer_set(vim.v.count1) end)

-- Previous/next quickfix item
keymap.set('n', ']q', '<CMD>cnext<CR>')
keymap.set('n', '[q', '<CMD>cprevious<CR>')

-- Open config in a new tab
keymap.set('n', '<Leader>vc', '<CMD>tabnew | edit $MYVIMRC<CR>')

-- Disable arrow keys
keymap.set({'n', 'i'}, '<Left>', '<Nop>')
keymap.set({'n', 'i'}, '<Right>', '<Nop>')
keymap.set({'n', 'i'}, '<Up>', '<Nop>')
keymap.set({'n', 'i'}, '<Down>', '<Nop>')

-- Quitall shortcut
keymap.set('n', '<Leader>qq', '<CMD>quitall<CR>')
keymap.set('n', '<Leader>QQ', '<CMD>quitall!<CR>')
