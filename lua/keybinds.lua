local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Make Y key yank to end of line
keymap.set('n', 'Y', 'y$', { noremap = true })

-- Make U redo
keymap.set('n', 'U', 'redo', { noremap = true })

-- Don't leave visual mode after indenting
keymap.set('v', '>', '>gv^', { noremap = true })
keymap.set('v', '<', '<gv^', { noremap = true })

-- Indent with Tab and Shift-Tab
keymap.set('v', '<Tab>', '>', {})
keymap.set('v', '<S-Tab>', '<', {})

-- Apply the . command to all selected lines in visual mode
keymap.set('v', '.', ':normal .<CR>', opts)

-- " Use Alt-L to clear the highlighting of :set hlsearch.
keymap.set('n', '<A-l>', ":nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>", opts)

-- Quit
keymap.set('n', '<Leader>qq', ':quitall<CR>', opts)
keymap.set('n', '<Leader>QQ', ':quitall!<CR>', opts)

-- Window keybinds
-- Goto window number
keymap.set('n', '<Leader>w1', ':1wincmd w<CR>', opts)
keymap.set('n', '<Leader>w2', ':2wincmd w<CR>', opts)
keymap.set('n', '<Leader>w3', ':3wincmd w<CR>', opts)
keymap.set('n', '<Leader>w4', ':4wincmd w<CR>', opts)
keymap.set('n', '<Leader>w5', ':5wincmd w<CR>', opts)
keymap.set('n', '<Leader>w6', ':6wincmd w<CR>', opts)
keymap.set('n', '<Leader>w7', ':7wincmd w<CR>', opts)
keymap.set('n', '<Leader>w8', ':8wincmd w<CR>', opts)
keymap.set('n', '<Leader>w9', ':9wincmd w<CR>', opts)

-- Resize windows
keymap.set('n', '<Leader>wr=', ':wincmd =<CR>', opts)
keymap.set('n', '<Leader>wr+', ':wincmd +<CR>', opts)
keymap.set('n', '<Leader>wr-', ':wincmd -<CR>', opts)
keymap.set('n', '<Leader>wr>', ':wincmd ><CR>', opts)
keymap.set('n', '<Leader>wr<', ':wincmd <<CR>', opts)

-- Rotate windows
keymap.set('n', '<Leader>wRb', ':wincmd r<CR>', opts)
keymap.set('n', '<Leader>wRu', ':wincmd R<CR>', opts)

-- Move between windows
keymap.set('n', '<Leader>wh', ':wincmd h<CR>', opts)
keymap.set('n', '<Leader>wj', ':wincmd j<CR>', opts)
keymap.set('n', '<Leader>wk', ':wincmd k<CR>', opts)
keymap.set('n', '<Leader>wl', ':wincmd l<CR>', opts)

-- Move windows
keymap.set('n', '<Leader>wx', ':wincmd x<CR>', opts)
keymap.set('n', '<Leader>wH', ':wincmd H<CR>', opts)
keymap.set('n', '<Leader>wJ', ':wincmd J<CR>', opts)
keymap.set('n', '<Leader>wK', ':wincmd K<CR>', opts)
keymap.set('n', '<Leader>wL', ':wincmd L<CR>', opts)

-- Close window
keymap.set('n', '<Leader>wq', ':quit<CR>', opts)
keymap.set('n', '<Leader>wQ', ':quit!<CR>', opts)

-- Split window
keymap.set('n', '<Leader>ws', ':wincmd s<CR>', opts)
keymap.set('n', '<Leader>wv', ':wincmd v<CR>', opts)

-- Buffer keybinds
-- Goto buffer number
keymap.set('n', '<Leader>b1', ':1buffer<CR>', opts)
keymap.set('n', '<Leader>b2', ':2buffer<CR>', opts)
keymap.set('n', '<Leader>b3', ':3buffer<CR>', opts)
keymap.set('n', '<Leader>b4', ':4buffer<CR>', opts)
keymap.set('n', '<Leader>b5', ':5buffer<CR>', opts)
keymap.set('n', '<Leader>b6', ':6buffer<CR>', opts)
keymap.set('n', '<Leader>b7', ':7buffer<CR>', opts)
keymap.set('n', '<Leader>b8', ':8buffer<CR>', opts)
keymap.set('n', '<Leader>b9', ':9buffer<CR>', opts)

-- Previous/next buffer
keymap.set('n', '[b', ':bprevious<CR>', opts)
keymap.set('n', ']b', ':bnext<CR>', opts)

-- Close buffer
keymap.set('n', '<Leader>bd', ':Bdelete<CR>', opts)
keymap.set('n', '<Leader>bw', ':Bwipeout<CR>', opts)
keymap.set('n', '<Leader>bD', ':Bdelete!<CR>', opts)
keymap.set('n', '<Leader>bW', ':Bwipeout!<CR>', opts)

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
keymap.set('n', '<C-t>', ':tabnew<CR>', opts)

-- Close tab
keymap.set('n', '<C-c>', ':tabclose<CR>', opts)
keymap.set('n', '<C-C>', ':tabclose!<CR>', opts)

-- Keybinds for editing vim config
keymap.set('n', 'vc', ':edit $MYVIMRC<CR>', opts)
