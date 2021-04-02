local bind = vim.api.nvim_set_keymap

-- Make Y key yank to end of line
bind('n', 'Y', 'y$', { noremap = true })

-- Make U redo
bind('n', 'U', 'undo', { noremap = true })

-- Don't leave visual mode after indenting
bind('v', '>', '>gv^', { noremap = true })
bind('v', '<', '<gv^', { noremap = true })

-- Indent with Tab and Shift-Tab
bind('v', '<Tab>', '>', {})
bind('v', '<S-Tab>', '<', {})

-- " Use <C-L> to clear the highlighting of :set hlsearch.
bind('n', '<C-L>',
    ":nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>",
    { noremap = true, silent = true })

-- Window keybinds
-- Goto window number
bind('n', '<Leader>wg1', ':exe 1 . "wincmd w"<CR>', { noremap = true, silent = true })
bind('n', '<Leader>wg2', ':exe 2 . "wincmd w"<CR>', { noremap = true, silent = true })
bind('n', '<Leader>wg3', ':exe 3 . "wincmd w"<CR>', { noremap = true, silent = true })
bind('n', '<Leader>wg4', ':exe 4 . "wincmd w"<CR>', { noremap = true, silent = true })
bind('n', '<Leader>wg5', ':exe 5 . "wincmd w"<CR>', { noremap = true, silent = true })
bind('n', '<Leader>wg6', ':exe 6 . "wincmd w"<CR>', { noremap = true, silent = true })
bind('n', '<Leader>wg7', ':exe 7 . "wincmd w"<CR>', { noremap = true, silent = true })
bind('n', '<Leader>wg8', ':exe 8 . "wincmd w"<CR>', { noremap = true, silent = true })
bind('n', '<Leader>wg9', ':exe 9 . "wincmd w"<CR>', { noremap = true, silent = true })

-- Goto window above/below/left/right
bind('n', '<Leader>wh', ':wincmd h<CR>', { noremap = true, silent = true })
bind('n', '<Leader>wj', ':wincmd j<CR>', { noremap = true, silent = true })
bind('n', '<Leader>wk', ':wincmd k<CR>', { noremap = true, silent = true })
bind('n', '<Leader>wl', ':wincmd l<CR>', { noremap = true, silent = true })

-- Resize windows
bind('n', '<Leader>wr=', ':wincmd =<CR>', { noremap = true, silent = true })
bind('n', '<Leader>wr+', ':wincmd +<CR>', { noremap = true, silent = true })
bind('n', '<Leader>wr-', ':wincmd -<CR>', { noremap = true, silent = true })
bind('n', '<Leader>wr>', ':wincmd ><CR>', { noremap = true, silent = true })
bind('n', '<Leader>wr<', ':wincmd <<CR>', { noremap = true, silent = true })

-- Rotate windows
bind('n', '<Leader>wRb', ':wincmd r<CR>', { noremap = true, silent = true })
bind('n', '<Leader>wRu', ':wincmd R<CR>', { noremap = true, silent = true })

-- Move windows
bind('n', '<Leader>wmx', ':wincmd x<CR>', { noremap = true, silent = true })
bind('n', '<Leader>wmh', ':wincmd h<CR>', { noremap = true, silent = true })
bind('n', '<Leader>wmj', ':wincmd j<CR>', { noremap = true, silent = true })
bind('n', '<Leader>wmk', ':wincmd k<CR>', { noremap = true, silent = true })
bind('n', '<Leader>wml', ':wincmd l<CR>', { noremap = true, silent = true })
