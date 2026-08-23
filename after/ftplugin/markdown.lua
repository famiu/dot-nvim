if vim.g.did_setup_markview then
    return
end

vim.cmd.packadd('markview.nvim')
require('markview').setup({})
vim.g.did_setup_markview = true
