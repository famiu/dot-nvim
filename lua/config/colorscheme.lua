local colorscheme = 'codedark' -- Name of colorscheme

-- Make Terminal use GUI colors
vim.o.termguicolors = true

-- Set colorscheme
vim.cmd('colorscheme '..colorscheme)

-- Set background color
vim.o.background = 'dark'
