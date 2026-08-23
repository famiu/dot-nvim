require('mini.align').setup({})
require('mini.ai').setup({})
require('mini.surround').setup({})

require('treesj').setup({ use_default_keymaps = false })

vim.keymap.set('n', 'gS', function()
    require('treesj').split()
end)

vim.keymap.set('n', 'gJ', function()
    require('treesj').join()
end)
