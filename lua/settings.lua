local g = vim.g
local cmd = vim.cmd
local fn = vim.fn
local opt = vim.opt
local create_augroup = require('utils').create_augroup

-- Set mapleader to space
vim.g.mapleader = ' '

-- Set localleader to comma
vim.g.maplocalleader = ','

-- Set encoding
opt.encoding = 'utf-8'

-- Default grep command
if fn.executable('rg') == 0 then
    vim.api.nvim_err_writeln(
        "Ripgrep not found in PATH. Please install ripgrep in order to use this configuration."
    )

    return
end

opt.grepprg = 'rg --vimgrep --smart-case'

--- Wildmenu
opt.wildmode = { 'longest', 'list', 'full' }

-- Enable mouse support
opt.mouse = 'a'

-- Persistent undo
opt.undofile = true

-- Use global statusline
opt.laststatus = 3

-- Indent
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Linebreak and wrap behavior
opt.linebreak = true
opt.breakindent = true

-- Fill column
opt.textwidth = 100
opt.colorcolumn = '+1'

-- Make Terminal use GUI colors
opt.termguicolors = true

-- Line numbers: Hybrid
opt.number = true
opt.relativenumber = true

-- Folding (with Treesitter)
opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'
opt.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').]] ..
    [[' ... '.trim(getline(v:foldend)).]] ..
    [[' ('.(v:foldend-v:foldstart).' lines folded...)']]
opt.fillchars = "fold: "
opt.foldlevel = 99
opt.foldnestmax = 3
opt.foldminlines = 4

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.gdefault = true

-- Completion
opt.completeopt = { 'menuone', 'preview' }
opt.shortmess:append('c')

-- Split options
opt.splitbelow = true
opt.splitright = true

-- Faster update time
opt.updatetime = 100

-- Highlight current line
opt.cursorline = true

-- Scroll offsets
opt.scrolloff = 10
opt.sidescrolloff = 5

-- Disable using netrw for 'gx' and set it manually
g.netrw_nogx = 1
vim.keymap.set('n', 'gx', '<cmd>!xdg-open <cfile><CR>', {})

-- Use LaTeX as default tex flavor
g.tex_flavor = "latex"

-- Highlight text on yank
create_augroup({
    {
        event = 'TextYankPost',
        opts = { callback = function() vim.highlight.on_yank() end }
    }
}, 'highlight_on_yank')

-- Remember last location in file
local no_restore_cursor_buftypes = {
    'quickfix', 'nofile', 'help', 'terminal'
}

local no_restore_cursor_filetypes = {
    'gitcommit', 'gitrebase'
}

local function RestoreCursor()
    if fn.line([['"]]) >= 1 and fn.line([['"]]) <= fn.line('$')
    and not vim.tbl_contains(no_restore_cursor_buftypes, opt.buftype:get())
    and not vim.tbl_contains(no_restore_cursor_filetypes, opt.filetype:get())
    then
        cmd('normal! g`" | zv')
    end
end

create_augroup({
    {
        event = 'BufReadPost',
        opts = { callback = RestoreCursor }
    }
}, 'RestoreCursorOnOpen')

-- Automatically create missing directories before save
local function create_file_directory_structure()
    local path = fn.expand('%:p:h')

    if fn.isdirectory(path) == 0 then
        fn.mkdir(path, 'p')
    end
end

create_augroup({
    {
        event = 'BufWritePre',
        opts = { callback = create_file_directory_structure }
    }
}, 'MkdirOnSave')
