-- Highlight text on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function() vim.highlight.on_yank() end,
    desc = 'Highlight on yank',
})

require('utilities.mkdir_on_save')
require('utilities.restore_cursor')
require('utilities.autocd')
require('utilities.tabline')
