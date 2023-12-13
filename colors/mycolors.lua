require('mini.hues').setup({
    background = '#141414',
    foreground = '#eaeaea',
    saturation = 'medium',
    accent = 'blue',
})

vim.api.nvim_set_hl(0, 'Type', { link = 'Identifier' })

vim.g.colors_name = 'mycolors'
