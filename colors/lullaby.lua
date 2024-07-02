vim.cmd.highlight('clear')

-- Custom overrides for default colorscheme
vim.api.nvim_set_hl(0, 'Keyword', { fg = 'NvimLightRed' })
vim.api.nvim_set_hl(0, 'Identifier', { fg = '#E6CDD3' })
vim.api.nvim_set_hl(0, 'Function', { fg = 'NvimLightBlue' })
vim.api.nvim_set_hl(0, 'Type', { fg = 'NvimLightYellow' })
vim.api.nvim_set_hl(0, 'Special', { fg = 'NvimLightCyan' })
vim.api.nvim_set_hl(0, 'Constant', { fg = '#C8DACD' })

vim.g.colors_name = 'lullaby'
