return {
    -- Colorscheme
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000,
        opts = {
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
                noice = true,
                snacks = {
                    enabled = true,
                },
            },
        },
        config = function(_, opts)
            require('catppuccin').setup(opts)
            vim.cmd.colorscheme('catppuccin')
        end,
    },
    { 'kevinhwang91/nvim-bqf', ft = 'qf' },
    {
        'mbbill/undotree',
        keys = {
            { '<Leader>u', '<CMD>UndotreeToggle<CR>' },
        },
    },
}
