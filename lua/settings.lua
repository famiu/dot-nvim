local g = vim.g

-- Set mapleader and maplocalloader
g.mapleader = ' '
g.maplocalleader = ','

-- Use LaTeX as default tex flavor
g.tex_flavor = 'latex'

-- Don't load netrw
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- Default grep command
vim.o.grepprg = 'rg --vimgrep --smart-case'

--- Wildmenu
vim.o.wildmode = 'longest,list,full'

-- Persistent undo
vim.o.undofile = true

-- Use global statusline
vim.o.laststatus = 3

-- Indent
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- Linebreak and wrap behavior
vim.o.linebreak = true
vim.o.breakindent = true

-- Fill column
vim.o.textwidth = 100
vim.o.colorcolumn = '+1'

-- Make Terminal use GUI colors
vim.o.termguicolors = true

-- Line numbers: Hybrid
vim.o.number = true
vim.o.relativenumber = true

-- Inccommand
vim.o.inccommand = 'split'

-- Folding configuration
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').]] ..
    [[' ... '.trim(getline(v:foldend)).]] ..
    [[' ('.(v:foldend-v:foldstart).' lines folded...)']]
vim.o.foldenable = false
vim.o.fillchars = 'fold: ,diff: '
vim.o.foldnestmax = 3
vim.o.foldminlines = 4

-- Session options
vim.o.sessionoptions = 'blank,folds,help,tabpages,winsize,winpos,terminal,localoptions'

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Substitution
vim.o.gdefault = true

-- Completion
vim.o.completeopt = 'menuone,preview,noselect'
vim.o.shortmess = vim.o.shortmess .. 'c'

-- Split options
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
