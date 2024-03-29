-- Use ripgrep for grepprg
vim.o.grepprg = 'rg --vimgrep --smart-case'

-- Better command line completion
vim.o.wildmode = 'longest:list,full'

-- Persistent undo, prevent Neovim from having Alzheimer's
vim.o.undofile = true

-- Use global statusline, not because I made it or anything
vim.o.laststatus = 3

-- Allow virtual editing in visual block mode and after the end of the line
vim.o.virtualedit = 'block,onemore'

-- Spaces > Tabs
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

-- Use hybrid line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Show inccommand preview with split
vim.o.inccommand = 'split'

-- Use space for diff fillchars
vim.o.fillchars = 'diff: '

-- Use transparent fold and disable folding by default
vim.o.foldtext = ''
vim.o.foldenable = false
vim.o.foldminlines = 4

-- Session options
vim.o.sessionoptions = 'blank,folds,help,tabpages,winsize,winpos,terminal,localoptions'

-- Use smartcase for searching
vim.o.ignorecase = true
vim.o.smartcase = true

-- Make substitute global by default
vim.o.gdefault = true

-- Settings for insert mode completion
vim.o.completeopt = 'menuone,preview,noselect'
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

-- Statuscolumn, show (hybrid) line number before signcolumn
vim.o.signcolumn = 'auto:2'
vim.o.statuscolumn = "%{%v:relnum?'%='.v:relnum:v:lnum.'%='%} %s"

-- Allow conceal to use replacement characters to hide text
vim.o.conceallevel = 2

-- Better listchars
vim.o.list = true
vim.o.listchars='tab:» ,extends:›,precedes:‹,nbsp:␣'

-- Remove "How-to disable mouse" from right-click menu
pcall(vim.cmd.aunmenu, [[PopUp.How-to\ disable\ mouse]])
pcall(vim.cmd.aunmenu, [[PopUp.-1-]])
