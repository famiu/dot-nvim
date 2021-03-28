local cmd = vim.cmd

local o = vim.o
local wo = vim.wo
local bo = vim.bo

local indent = 4
local text_width = 90

local config_dir = vim.fn.stdpath('config')
local data_dir = vim.fn.stdpath('data')
local runtimepath = { config_dir, data_dir, data_dir..'/after' }

-- Set encoding
o.encoding = 'utf-8'

-- Wildmenu
o.wildmode = 'longest,list,full'
o.wildmenu = true

-- Hidden buffers to switch buffers without saving
o.hidden = true

-- Enable mouse support
o.mouse = 'a'

-- Project specific vimrc with secure
o.exrc = true
o.secure = true

-- GUI cursor
o.guicursor = 'n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,'..
	'a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,'..
	'sm:block-blinkwait175-blinkoff150-blinkon175'

-- Persistent undo
o.undofile = true

-- Indent
bo.tabstop = indent
bo.shiftwidth = indent
bo.expandtab = true
bo.autoindent = true
bo.smartindent = true

-- Linebreak and wrap behavior
wo.linebreak = true
wo.breakindent = true
wo.wrap = true
bo.textwidth = text_width

-- Show fill column indicator
wo.colorcolumn = '+1'

-- Line numbers: Hybrid
wo.number = true
wo.relativenumber = true

-- Folding (with Treesitter)
wo.foldmethod = 'expr'
wo.foldexpr = 'nvim_treesitter#foldexpr()'
wo.foldlevel = 99

-- Search
o.hlsearch = true
o.incsearch = true
o.ignorecase = true
o.smartcase = true

-- Incremental command
o.inccommand = 'nosplit'

-- Completion
o.completeopt = 'menuone,preview,noselect'
o.shortmess = o.shortmess..'c'

-- Split options
o.splitbelow = true
o.splitright = true

-- Faster update time
o.updatetime = 100
o.signcolumn = 'auto:4'

-- Highlight current line
o.cursorline = true

-- Make sure that there's always ten lines above or below the cursor
o.scrolloff = 10

-- GUI Font
o.guifont = 'JetBrainsMono Nerd Font Mono:h10'

-- Enable filetype plugin
cmd 'filetype plugin on'

-- Automatically switch current window directory to directory of current file
cmd 'autocmd BufEnter * silent! lcd %:p:h'
