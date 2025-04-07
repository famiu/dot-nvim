-- Set mapleader and maplocalloader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Better command line completion
vim.o.wildmode = 'longest,full'

-- Persistent undo, prevent Neovim from having Alzheimer's
vim.o.undofile = true

-- Disable "Hit ENTER to continue" messages
vim.o.messagesopt = 'wait:500,history:500'

-- Use global statusline, not because I made it or anything
vim.o.laststatus = 3

-- Use statusline area for cmdline
vim.o.cmdheight = 0

-- Allow virtual editing
vim.o.virtualedit = 'all'

-- Spaces > Tabs
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- Linebreak and wrap behavior
vim.o.wrap = true
vim.o.linebreak = true
vim.o.breakindent = true
vim.o.showbreak = '↪ '

-- Fill column indicator
vim.o.colorcolumn = '+1'

-- Show inccommand preview with split
vim.o.inccommand = 'split'

-- Use transparent fold and use treesitter for folding
vim.o.foldtext = ''
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldlevelstart = 20

-- Session options
vim.o.sessionoptions = 'blank,folds,help,tabpages,winsize,winpos,terminal,localoptions'

-- Use smartcase for searching
vim.o.ignorecase = true
vim.o.smartcase = true

-- Make substitute global by default
vim.o.gdefault = true

-- Settings for insert mode completion
vim.o.completeopt = 'menuone,popup,noinsert,fuzzy'
vim.o.shortmess = vim.o.shortmess .. 'c'

-- Split behavior
vim.o.splitbelow = true
vim.o.splitright = true

-- Better diff behavior
vim.o.diffopt = 'internal,filler,closeoff,hiddenoff,vertical,indent-heuristic,linematch:60'

-- Faster update time
vim.o.updatetime = 100

-- Highlight current line
vim.o.cursorline = true

-- Scroll offsets
vim.o.scrolloff = 10
vim.o.sidescrolloff = 5

-- Scroll based on screen lines instead of logical lines
vim.o.smoothscroll = true

-- Allow project specific configuration
vim.o.exrc = true

-- Show hybrid line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Allow signcolumn to show up to 2 signs
vim.o.signcolumn = 'auto:2'

-- Enable foldcolumn
vim.o.foldcolumn = '1'

-- Allow conceal to use replacement characters to hide text
vim.o.conceallevel = 2

-- Better listchars
vim.o.list = true
vim.o.listchars = 'tab:» ,extends:›,precedes:‹,nbsp:␣'

-- Remove "How-to disable mouse" from right-click menu
pcall(vim.cmd.aunmenu, [[PopUp.How-to\ disable\ mouse]])
pcall(vim.cmd.aunmenu, [[PopUp.-2-]])
