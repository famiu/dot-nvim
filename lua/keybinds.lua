local keymap = vim.keymap

-- Map H and L to ^ and $
keymap.set('n', 'H', '^')
keymap.set('n', 'L', '$')

-- Make J and K move selected lines up and down
keymap.set('v', 'J', ":move '>+1<CR>gv=gv", { silent = true })
keymap.set('v', 'K', ":move '<-2<CR>gv=gv", { silent = true })

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

-- Previous/next buffer
keymap.set('n', '[b', '<CMD>bprevious<CR>')
keymap.set('n', ']b', '<CMD>bnext<CR>')

-- Tab keybinds
-- Go to tab number
keymap.set('n', '<Leader>t1', '<CMD>tabnext1<CR>')
keymap.set('n', '<Leader>t2', '<CMD>tabnext2<CR>')
keymap.set('n', '<Leader>t3', '<CMD>tabnext3<CR>')
keymap.set('n', '<Leader>t4', '<CMD>tabnext4<CR>')
keymap.set('n', '<Leader>t5', '<CMD>tabnext5<CR>')
keymap.set('n', '<Leader>t6', '<CMD>tabnext6<CR>')
keymap.set('n', '<Leader>t7', '<CMD>tabnext7<CR>')
keymap.set('n', '<Leader>t8', '<CMD>tabnext8<CR>')
keymap.set('n', '<Leader>t9', '<CMD>tabnext9<CR>')

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

-- Open config
keymap.set('n', '<Leader>vc', '<CMD>edit $MYVIMRC<CR>')

-- Trim trailing whitespace in file
keymap.set('n', '<Leader>t<Space>', [[<CMD>%s/\s\+$//e<CR>]])

-- Disable arrow keys
keymap.set({'n', 'i'}, '<Left>', '<Nop>')
keymap.set({'n', 'i'}, '<Right>', '<Nop>')
keymap.set({'n', 'i'}, '<Up>', '<Nop>')
keymap.set({'n', 'i'}, '<Down>', '<Nop>')

-- Quitall shortcut
keymap.set('n', '<Leader>qq', '<CMD>quitall<CR>')
keymap.set('n', '<Leader>QQ', '<CMD>quitall!<CR>')

-- Indent pasted text
keymap.set('n', '<Leader>p=', "'[v']=")
