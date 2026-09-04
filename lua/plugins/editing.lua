require('mini.align').setup({})
require('mini.extra').setup({})

local gen_spec = require('mini.ai').gen_spec

require('mini.ai').setup({
    custom_textobjects = {
        -- Makes `aB` equivalent to built-in `al`
        B = MiniExtra.gen_ai_spec.buffer(),
        -- Makes `iL` equivalent to built-in `il`
        L = MiniExtra.gen_ai_spec.line(),
        -- Treesitter textobjects
        F = gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
        c = gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }),
        d = gen_spec.treesitter({ a = '@conditional.outer', i = '@conditional.inner' }),
        o = gen_spec.treesitter({ a = '@loop.outer', i = '@loop.inner' }),
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
