return {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {
        jump = {
            autojump = true,
        },
        label = {
            uppercase = false,
        },
        modes = {
            search = {
                enabled = true
            },
        },
    },
    keys = {
        {
            's',
            mode = { 'n', 'x', 'o' },
            function()
                -- default options: exact mode, multi window, all directions, with a backdrop
                require('flash').jump()
            end,
            desc = 'Flash',
        },
        {
            'S',
            mode = { 'n', 'o', 'x' },
            function()
                require('flash').treesitter()
            end,
            desc = 'Flash Treesitter',
        },
        {
            'r',
            mode = 'o',
            function()
                require('flash').remote()
            end,
            desc = 'Remote Flash',
        },
        {
            "<c-s>",
            mode = { "c" },
            function()
                require("flash").toggle()
            end,
            desc = "Toggle Flash Search",
        },
    },
}
