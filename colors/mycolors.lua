require('mini.hues').setup({
    background = '#141414',
    foreground = '#eaeaea',
    saturation = 'medium',
    accent = 'blue',
})

vim.api.nvim_set_hl(0, 'StatusLine', { fg = '#c3c3c3', bg = '#080808' })
vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = '#c3c3c3', bg = '#0c0c0c' })
vim.api.nvim_set_hl(0, 'Type', { link = 'Identifier' })

vim.g.colors_name = 'mycolors'
