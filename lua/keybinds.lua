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
bind('n', '<Leader>q', ':quitall<CR>', opts)
bind('n', '<Leader>Q', ':quitall!<CR>', opts)

-- Window keybinds
-- Goto window number
bind('n', 'w1', ':exe 1 . "wincmd w"<CR>', opts)
bind('n', 'w2', ':exe 2 . "wincmd w"<CR>', opts)
bind('n', 'w3', ':exe 3 . "wincmd w"<CR>', opts)
bind('n', 'w4', ':exe 4 . "wincmd w"<CR>', opts)
bind('n', 'w5', ':exe 5 . "wincmd w"<CR>', opts)
bind('n', 'w6', ':exe 6 . "wincmd w"<CR>', opts)
bind('n', 'w7', ':exe 7 . "wincmd w"<CR>', opts)
bind('n', 'w8', ':exe 8 . "wincmd w"<CR>', opts)
bind('n', 'w9', ':exe 9 . "wincmd w"<CR>', opts)

-- Goto window above/below/left/right
bind('n', 'wh', ':wincmd h<CR>', opts)
bind('n', 'wj', ':wincmd j<CR>', opts)
bind('n', 'wk', ':wincmd k<CR>', opts)
bind('n', 'wl', ':wincmd l<CR>', opts)

-- Resize windows
bind('n', 'wr=', ':wincmd =<CR>', opts)
bind('n', 'wr+', ':wincmd +<CR>', opts)
bind('n', 'wr-', ':wincmd -<CR>', opts)
bind('n', 'wr>', ':wincmd ><CR>', opts)
bind('n', 'wr<', ':wincmd <<CR>', opts)

-- Rotate windows
bind('n', 'wRb', ':wincmd r<CR>', opts)
bind('n', 'wRu', ':wincmd R<CR>', opts)

-- Move windows
bind('n', 'wx', ':wincmd x<CR>', opts)
bind('n', 'wH', ':wincmd h<CR>', opts)
bind('n', 'wJ', ':wincmd j<CR>', opts)
bind('n', 'wK', ':wincmd k<CR>', opts)
bind('n', 'wL', ':wincmd l<CR>', opts)

-- Delete window
bind('n', 'qq', ':wincmd q<CR>', opts)

-- Split window
bind('n', 'ws', ':wincmd s<CR>', opts)
bind('n', 'wv', ':wincmd v<CR>', opts)

-- Keybinds for editing vim config
bind('n', 'vc', ':edit $MYVIMRC<CR>', opts)
