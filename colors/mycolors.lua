-- Use mini.hues for setting up most highlights
require('mini.hues').setup({
    background = '#141414',
    foreground = '#eaeaea',
    saturation = 'medium',
    accent = 'blue',
})

-- Statusline highlights
vim.api.nvim_set_hl(0, 'StatusLine', { fg = '#c3c3c3', bg = '#080808' })
vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = '#c3c3c3', bg = '#0c0c0c' })

-- Diff highlights
vim.api.nvim_set_hl(0, 'DiffAdd', { bg = '#142314' })
vim.api.nvim_set_hl(0, 'DiffDelete', { bg = '#231414' })
vim.api.nvim_set_hl(0, 'DiffChange', { bg = '#232314' })

-- Identifier
vim.api.nvim_set_hl(0, 'Type', { link = 'Identifier' })

vim.g.colors_name = 'mycolors'
