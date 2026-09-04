require('mini.align').setup({})
require('mini.extra').setup({})
require('mini.ai').setup({
    custom_textobjects = {
        -- Makes `aB` equivalent to built-in `al`
        B = MiniExtra.gen_ai_spec.buffer(),
        -- Makes `iL` equivalent to built-in `il`
        L = MiniExtra.gen_ai_spec.line(),
    },
})
require('mini.surround').setup({})

require('treesj').setup({ use_default_keymaps = false })

vim.keymap.set('n', 'gS', function()
    require('treesj').split()
end)

vim.keymap.set('n', 'gJ', function()
    require('treesj').join()
end)
