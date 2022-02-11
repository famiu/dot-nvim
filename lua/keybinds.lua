local bind = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Make Y key yank to end of line
bind('n', 'Y', 'y$', { noremap = true })

-- Make U redo
bind('n', 'U', 'redo', { noremap = true })

-- Don't leave visual mode after indenting
bind('v', '>', '>gv^', { noremap = true })
bind('v', '<', '<gv^', { noremap = true })

-- Indent with Tab and Shift-Tab
bind('v', '<Tab>', '>', {})
bind('v', '<S-Tab>', '<', {})

-- Apply the . command to all selected lines in visual mode
bind('v', '.', ':normal .<CR>', opts)

-- " Use Alt-L to clear the highlighting of :set hlsearch.
bind('n', '<A-l>', ":nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>", opts)

-- Quit
bind('n', '<Leader>qq', ':quitall<CR>', opts)
bind('n', '<Leader>QQ', ':quitall!<CR>', opts)

-- Window keybinds
-- Goto window number
bind('n', '<Leader>w1', ':1wincmd w<CR>', opts)
bind('n', '<Leader>w2', ':2wincmd w<CR>', opts)
bind('n', '<Leader>w3', ':3wincmd w<CR>', opts)
bind('n', '<Leader>w4', ':4wincmd w<CR>', opts)
bind('n', '<Leader>w5', ':5wincmd w<CR>', opts)
bind('n', '<Leader>w6', ':6wincmd w<CR>', opts)
bind('n', '<Leader>w7', ':7wincmd w<CR>', opts)
bind('n', '<Leader>w8', ':8wincmd w<CR>', opts)
bind('n', '<Leader>w9', ':9wincmd w<CR>', opts)

-- Resize windows
bind('n', '<Leader>wr=', ':wincmd =<CR>', opts)
bind('n', '<Leader>wr+', ':wincmd +<CR>', opts)
bind('n', '<Leader>wr-', ':wincmd -<CR>', opts)
bind('n', '<Leader>wr>', ':wincmd ><CR>', opts)
bind('n', '<Leader>wr<', ':wincmd <<CR>', opts)

-- Rotate windows
bind('n', '<Leader>wRb', ':wincmd r<CR>', opts)
bind('n', '<Leader>wRu', ':wincmd R<CR>', opts)

-- Move between windows
bind('n', '<Leader>wh', ':wincmd h<CR>', opts)
bind('n', '<Leader>wj', ':wincmd j<CR>', opts)
bind('n', '<Leader>wk', ':wincmd k<CR>', opts)
bind('n', '<Leader>wl', ':wincmd l<CR>', opts)

-- Move windows
bind('n', '<Leader>wx', ':wincmd x<CR>', opts)
bind('n', '<Leader>wH', ':wincmd H<CR>', opts)
bind('n', '<Leader>wJ', ':wincmd J<CR>', opts)
bind('n', '<Leader>wK', ':wincmd K<CR>', opts)
bind('n', '<Leader>wL', ':wincmd L<CR>', opts)

-- Close window
bind('n', '<Leader>wq', ':quit<CR>', opts)
bind('n', '<Leader>wQ', ':quit!<CR>', opts)

-- Split window
bind('n', '<Leader>ws', ':wincmd s<CR>', opts)
bind('n', '<Leader>wv', ':wincmd v<CR>', opts)

-- Buffer keybinds
-- Goto buffer number
bind('n', '<Leader>b1', ':1buffer<CR>', opts)
bind('n', '<Leader>b2', ':2buffer<CR>', opts)
bind('n', '<Leader>b3', ':3buffer<CR>', opts)
bind('n', '<Leader>b4', ':4buffer<CR>', opts)
bind('n', '<Leader>b5', ':5buffer<CR>', opts)
bind('n', '<Leader>b6', ':6buffer<CR>', opts)
bind('n', '<Leader>b7', ':7buffer<CR>', opts)
bind('n', '<Leader>b8', ':8buffer<CR>', opts)
bind('n', '<Leader>b9', ':9buffer<CR>', opts)

-- Previous/next buffer
bind('n', '[b', ':bprevious<CR>', opts)
bind('n', ']b', ':bnext<CR>', opts)

-- Close buffer
bind('n', '<Leader>bd', ':Bdelete<CR>', opts)
bind('n', '<Leader>bw', ':Bwipeout<CR>', opts)
bind('n', '<Leader>bD', ':Bdelete!<CR>', opts)
bind('n', '<Leader>bW', ':Bwipeout!<CR>', opts)

-- Tab keybinds
-- Goto tab number
bind('n', '<A-1>', ':tabnext1<CR>', opts)
bind('n', '<A-2>', ':tabnext2<CR>', opts)
bind('n', '<A-3>', ':tabnext3<CR>', opts)
bind('n', '<A-4>', ':tabnext4<CR>', opts)
bind('n', '<A-5>', ':tabnext5<CR>', opts)
bind('n', '<A-6>', ':tabnext6<CR>', opts)
bind('n', '<A-7>', ':tabnext7<CR>', opts)
bind('n', '<A-8>', ':tabnext8<CR>', opts)
bind('n', '<A-9>', ':tabnext9<CR>', opts)

-- Previous/next tab
bind('n', '[t', ':tabprevious<CR>', opts)
bind('n', ']t', ':tabnext<CR>', opts)

-- New tab
bind('n', '<C-t>', ':tabnew<CR>', opts)

-- Close tab
bind('n', '<C-c>', ':tabclose<CR>', opts)
bind('n', '<C-C>', ':tabclose!<CR>', opts)

-- Keybinds for editing vim config
bind('n', 'vc', ':edit $MYVIMRC<CR>', opts)
