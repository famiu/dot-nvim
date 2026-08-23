if vim.g.did_setup_typst_preview then
    return
end

vim.cmd.packadd('typst-preview.nvim')
require('typst-preview').setup({
    dependencies_bin = { tinymist = 'tinymist' },
})
vim.g.did_setup_typst_preview = true
