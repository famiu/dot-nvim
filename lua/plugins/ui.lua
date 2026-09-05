local catppuccin_opts = {
    transparent_background = true,
    float = {
        transparent = true,
    },
    integrations = {
        blink_cmp = true,
        diffview = true,
        dropbar = true,
        harpoon = true,
        mason = true,
        snacks = {
            enabled = true,
        },
    },
}

require('catppuccin').setup(catppuccin_opts)
vim.cmd.colorscheme('catppuccin')

require('tiny-cmdline').setup({
    position = {
        x = '50%',
        y = '10%',
    },
    on_reposition = require('tiny-cmdline').adapters.blink,
})
