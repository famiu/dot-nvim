local bind = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

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

-- Apply the . command to all selected lines in visual mode
bind('v', '.', ':normal .<CR>', opts)

-- " Use Alt-L to clear the highlighting of :set hlsearch.
bind('n', '<A-l>', ":nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>", opts)

-- Quit
bind('n', '<Leader>q', ':quitall<CR>', opts)
bind('n', '<Leader>Q', ':quitall!<CR>', opts)

-- Window keybinds
-- Goto window number
bind('n', '<Leader>w1', ':exe 1 . "wincmd w"<CR>', opts)
bind('n', '<Leader>w2', ':exe 2 . "wincmd w"<CR>', opts)
bind('n', '<Leader>w3', ':exe 3 . "wincmd w"<CR>', opts)
bind('n', '<Leader>w4', ':exe 4 . "wincmd w"<CR>', opts)
bind('n', '<Leader>w5', ':exe 5 . "wincmd w"<CR>', opts)
bind('n', '<Leader>w6', ':exe 6 . "wincmd w"<CR>', opts)
bind('n', '<Leader>w7', ':exe 7 . "wincmd w"<CR>', opts)
bind('n', '<Leader>w8', ':exe 8 . "wincmd w"<CR>', opts)
bind('n', '<Leader>w9', ':exe 9 . "wincmd w"<CR>', opts)

-- Goto window above/below/left/right
bind('n', '<Leader>wh', ':wincmd h<CR>', opts)
bind('n', '<Leader>wj', ':wincmd j<CR>', opts)
bind('n', '<Leader>wk', ':wincmd k<CR>', opts)
bind('n', '<Leader>wl', ':wincmd l<CR>', opts)

-- Resize windows
bind('n', '<Leader>wr=', ':wincmd =<CR>', opts)
bind('n', '<Leader>wr+', ':wincmd +<CR>', opts)
bind('n', '<Leader>wr-', ':wincmd -<CR>', opts)
bind('n', '<Leader>wr>', ':wincmd ><CR>', opts)
bind('n', '<Leader>wr<', ':wincmd <<CR>', opts)

-- Rotate windows
bind('n', '<Leader>wRb', ':wincmd r<CR>', opts)
bind('n', '<Leader>wRu', ':wincmd R<CR>', opts)

-- Move windows
bind('n', '<Leader>wmx', ':wincmd x<CR>', opts)
bind('n', '<Leader>wmh', ':wincmd h<CR>', opts)
bind('n', '<Leader>wmj', ':wincmd j<CR>', opts)
bind('n', '<Leader>wmk', ':wincmd k<CR>', opts)
bind('n', '<Leader>wml', ':wincmd l<CR>', opts)

-- Delete window
bind('n', '<Leader>wq', ':wincmd q<CR>', opts)

-- Split window
bind('n', '<Leader>ws', ':wincmd s<CR>', opts)
bind('n', '<Leader>wv', ':wincmd v<CR>', opts)

-- Keybinds for editing vim config
bind('n', '<Leader>vc', ':edit $MYVIMRC<CR>', opts)
bind('n', '<Leader>vr', ':lua require("nvim-reload").Reload()<CR>', opts)
bind('n', '<Leader>vR', ':lua require("nvim-reload").Restart()<CR>', opts)
bind('n', '<Leader>vv', ':version<CR>', opts)

local keys = {
    q = 'Quit all',
    Q = 'Quit all without save',
    w = {
        name = '+windows',
        ['1'] = 'Window 1',
        ['2'] = 'Window 2',
        ['3'] = 'Window 3',
        ['4'] = 'Window 4',
        ['5'] = 'Window 5',
        ['6'] = 'Window 6',
        ['7'] = 'Window 7',
        ['8'] = 'Window 8',
        ['9'] = 'Window 9',
        h = 'Go to window left',
        j = 'Go to window below',
        k = 'Go to window above',
        l = 'Go to window right',
        r = {
            name = '+resize',
            ['='] = 'Balance windows',
            ['+'] = 'Increase window height',
            ['-'] = 'Decrease window height',
            ['>'] = 'Increase window width',
            ['<'] = 'Decrease window width',
        },
        R = {
            name = '+rotate',
            b = 'Rotate down/right',
            u = 'Rotate up/left',
        },
        m = {
            name = '+move',
            x = 'Exchange windows',
            h = 'Move window left',
            j = 'Move window below',
            k = 'Move window above',
            l = 'Move window right'
        },
        q = 'Delete window',
        s = 'Split horizontally',
        v = 'Split vertically',
    },
    v = {
        name = '+vim',
        c = 'Edit config',
        r = 'Reload',
        R = 'Restart',
        v = 'Version'
    }
}

require('which-key').register(keys, { prefix = "<leader>" })
