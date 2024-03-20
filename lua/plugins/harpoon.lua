return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
    keys = {
        { '<Leader>h', function() require('harpoon'):list():append() end },
        { '<Leader>H', function() require('harpoon'):list():prepend() end },
        {
            '<C-e>',
            function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end,
        },
        { '<Leader>1', function() require('harpoon'):list():select(1) end },
        { '<Leader>2', function() require('harpoon'):list():select(2) end },
        { '<Leader>3', function() require('harpoon'):list():select(3) end },
        { '<Leader>4', function() require('harpoon'):list():select(4) end },
        { '<Leader>5', function() require('harpoon'):list():select(5) end },

        -- Previous/next buffer using harpoon.
        { '[b', function() require('harpoon'):list():prev() end },
        { ']b', function() require('harpoon'):list():next() end },
    },
}
