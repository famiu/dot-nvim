local keymap = vim.keymap
local opts = { silent = true }

-- Don't leave visual mode after indenting
keymap.set('v', '>', '>gv^', {})
keymap.set('v', '<', '<gv^', {})

-- Indent with Tab and Shift-Tab
keymap.set('v', '<Tab>', '>', {})
keymap.set('v', '<S-Tab>', '<', {})

-- Apply the . command to all selected lines in visual mode
keymap.set('v', '.', ':normal .<CR>', opts)

-- Previous/next buffer
keymap.set('n', '[b', ':bprevious<CR>', opts)
keymap.set('n', ']b', ':bnext<CR>', opts)

-- Tab keybinds
-- Goto tab number
keymap.set('n', '<A-1>', ':tabnext1<CR>', opts)
keymap.set('n', '<A-2>', ':tabnext2<CR>', opts)
keymap.set('n', '<A-3>', ':tabnext3<CR>', opts)
keymap.set('n', '<A-4>', ':tabnext4<CR>', opts)
keymap.set('n', '<A-5>', ':tabnext5<CR>', opts)
keymap.set('n', '<A-6>', ':tabnext6<CR>', opts)
keymap.set('n', '<A-7>', ':tabnext7<CR>', opts)
keymap.set('n', '<A-8>', ':tabnext8<CR>', opts)
keymap.set('n', '<A-9>', ':tabnext9<CR>', opts)

-- Previous/next tab
keymap.set('n', '[t', ':tabprevious<CR>', opts)
keymap.set('n', ']t', ':tabnext<CR>', opts)

-- Move current tab
keymap.set('n', '[T', ':tabmove -1<CR>', opts)
keymap.set('n', ']T', ':tabmove +1<CR>', opts)

-- New tab
keymap.set('n', '<C-n>', ':tabnew<CR>', opts)

-- Close tab
keymap.set('n', '<A-x>', ':tabclose<CR>', opts)
keymap.set('n', '<A-X>', ':tabclose!<CR>', opts)
