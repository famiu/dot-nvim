local cmd = vim.cmd
local set_opt = require('utils').set_opt
local get_opt = require('utils').get_opt

local fill_column = 90

-- Set encoding
set_opt('o', 'encoding', 'utf-8')

-- Wildmenu
set_opt('o', 'wildmode', 'longest,list,full')
set_opt('o', 'wildmenu', true)

-- Hidden buffers to switch buffers without saving
set_opt('o', 'hidden', true)

-- Enable mouse support
set_opt('o', 'mouse', 'a')

-- Project specific vimrc with secure
set_opt('o', 'exrc', true)
set_opt('o', 'secure', true)

-- GUI cursor
set_opt('o', 'guicursor', 'n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,'..
	'a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,'..
	'sm:block-blinkwait175-blinkoff150-blinkon175')

-- Persistent undo
set_opt('o', 'undofile', true)

-- Auto read file changes
set_opt('o', 'autoread', true)

-- Backspace
set_opt('o', 'backspace', 'indent,eol,start')

-- Make last window always have a status line
set_opt('o', 'laststatus', 2)

-- Indent
-- o.tabstop = 8
set_opt('b', 'softtabstop', 4)
set_opt('b', 'shiftwidth', 4)
set_opt('b', 'expandtab', true)
set_opt('b', 'autoindent', true)
set_opt('b', 'smartindent', true)

-- Listchars
set_opt('o', 'listchars', 'tab:> ,trail:-,extends:>,precedes:<,nbsp:+')

-- Linebreak and wrap behavior
set_opt('w', 'linebreak', true)
set_opt('w', 'breakindent', true)

-- Show fill column indicator
set_opt('w', 'colorcolumn', tostring(fill_column + 1))

-- Line numbers: Hybrid
set_opt('w', 'number', true)
set_opt('w', 'relativenumber', true)

-- Folding (with Treesitter)
set_opt('w', 'foldmethod', 'expr')
set_opt('w', 'foldexpr', 'nvim_treesitter#foldexpr()')
set_opt('w', 'foldlevel', 99)

-- Search
set_opt('o', 'hlsearch', true)
set_opt('o', 'incsearch', true)
set_opt('o', 'ignorecase', true)
set_opt('o', 'smartcase', true)

-- Incremental command
set_opt('o', 'inccommand', 'nosplit')

-- Completion
set_opt('o', 'completeopt', 'menuone,preview,noselect')
set_opt('o', 'shortmess', get_opt('o', 'shortmess') .. 'c')

-- Split options
set_opt('o', 'splitbelow', true)
set_opt('o', 'splitright', true)

-- Faster update time
set_opt('o', 'updatetime', 100)
set_opt('o', 'signcolumn', 'auto:4')

-- Highlight current line
set_opt('o', 'cursorline', true)

-- Scroll offsets
set_opt('o', 'scrolloff', 10)
set_opt('o', 'sidescrolloff', 5)

-- GUI Font
set_opt('o', 'guifont', 'JetBrainsMono Nerd Font Mono:h10')

-- Enable filetype plugin
cmd 'filetype plugin on'

-- Automatically switch current window directory to directory of current file
cmd 'autocmd BufEnter * silent! lcd %:p:h'

-- Highlight text on yank
cmd 'autocmd TextYankPost * silent! lua vim.highlight.on_yank()'
