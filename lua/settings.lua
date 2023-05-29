local g = vim.g
local fn = vim.fn

-- Set mapleader to space
vim.g.mapleader = ' '

-- Default grep command
if fn.executable('rg') == 0 then
    vim.notify_once(
        'Ripgrep not found in PATH. Please install ripgrep in order to use this configuration.',
        vim.log.levels.ERROR
    )

    return
end

vim.o.grepprg = 'rg --vimgrep --smart-case'

--- Wildmenu
vim.o.wildmode = 'longest:list:full'

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

-- Folding configuration
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').]] ..
    [[' ... '.trim(getline(v:foldend)).]] ..
    [[' ('.(v:foldend-v:foldstart).' lines folded...)']]
vim.o.foldenable = false
vim.o.fillchars = 'fold: '
vim.o.foldnestmax = 3
vim.o.foldminlines = 4

-- Session options
vim.o.sessionoptions = "blank,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Completion
vim.o.completeopt = 'menuone,preview'
vim.o.shortmess = vim.o.shortmess .. 'c'

-- Split options
vim.o.splitbelow = true
vim.o.splitright = true

-- Diff options
vim.o.diffopt = "internal,filler,closeoff,vertical,linematch:60"

-- Faster update time
vim.o.updatetime = 100

-- Highlight current line
vim.o.cursorline = true

-- Scroll offsets
vim.o.scrolloff = 10
vim.o.sidescrolloff = 5

-- Allow project specific configuration
vim.o.exrc = true

-- Allow mouse move events
vim.o.mousemoveevent = true

-- Disable using netrw for 'gx' and set it manually
g.netrw_nogx = 1
vim.keymap.set('n', 'gx', '<cmd>!xdg-open <cfile><CR>', {})

-- Use LaTeX as default tex flavor
g.tex_flavor = 'latex'
