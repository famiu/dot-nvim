-- Use ripgrep for grepprg
vim.o.grepprg = 'rg --vimgrep --smart-case'

--- Wildmenu
vim.o.wildmode = 'longest,list,full'

-- Persistent undo
vim.o.undofile = true

-- Use global statusline
vim.o.laststatus = 3

-- Spaces > Tabs
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- Linebreak and wrap behavior
vim.o.wrap = true
vim.o.linebreak = true
vim.o.breakindent = true
vim.o.showbreak = '↪ '

-- Fill column
vim.o.colorcolumn = '+1'

-- Use hybrid line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Show inccommand preview with split
vim.o.inccommand = 'split'

-- Use space for fold and diff fillchars
vim.o.fillchars = 'fold: ,diff: '

-- Fold settings
vim.o.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').]]
    .. [[' ... '.trim(getline(v:foldend)).]]
    .. [[' ('.(v:foldend-v:foldstart).' lines folded...)']]
vim.o.foldenable = false
vim.o.foldminlines = 4

-- Session options
vim.o.sessionoptions = 'blank,folds,help,tabpages,winsize,winpos,terminal,localoptions'

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Make substitute global by default
vim.o.gdefault = true

-- Completion
vim.o.completeopt = 'menuone,preview,noselect'
vim.o.shortmess = vim.o.shortmess .. 'c'

-- Split behavior
vim.o.splitbelow = true
vim.o.splitright = true

-- Diff options
vim.o.diffopt = 'internal,filler,closeoff,hiddenoff,vertical,iwhite,indent-heuristic,linematch:60'

-- Faster update time
vim.o.updatetime = 100

-- Highlight current line
vim.o.cursorline = true

-- Scroll
vim.o.scrolloff = 10
vim.o.sidescrolloff = 5
vim.o.smoothscroll = true

-- Allow project specific configuration
vim.o.exrc = true

-- Mouse
vim.o.mouse = 'nv'
vim.o.mousemoveevent = true

-- Statuscolumn
vim.o.signcolumn = 'auto:2'
vim.o.statuscolumn = "%{%v:relnum?'%='.v:relnum:v:lnum.'%='%} %s"

-- Conceal
vim.o.conceallevel = 2

-- Remove "How-to disable mouse" from right-click menu
vim.cmd.aunmenu([[PopUp.How-to\ disable\ mouse]])
vim.cmd.aunmenu([[PopUp.-1-]])
