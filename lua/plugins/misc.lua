return {
    {
        'famiu/bufdelete.nvim',
        name = 'bufdelete',
        dev = true,
        keys = {
            { '<Leader>x', '<CMD>Bdelete<CR>' },
            { '<Leader>X', '<CMD>Bwipeout<CR>' },
        },
        cmd = { 'Bdelete', 'Bwipeout' },
    },
    {
        'williamboman/mason.nvim',
        opts = {
            PATH = 'append',
            max_concurrent_installers = require('utilities.os').pu_count(),
        },
    },
    {
        'stevearc/oil.nvim',
        lazy = false,
        opts = {
            -- Make split mappings consistent with Telescope.
            keymaps = {
                ['<C-s>'] = false,
                ['<C-h>'] = false,
                ['<C-v>'] = 'actions.select_vsplit',
                ['<C-x>'] = 'actions.select_split',
            },
        },
        keys = { { '<Leader>o', '<CMD>Oil<CR>' } },
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    'tpope/vim-eunuch',
    {
        'lewis6991/hover.nvim',
        config = function()
            require('hover').setup({
                init = function()
                    -- Require providers
                    require('hover.providers.lsp')
                    require('hover.providers.gh')
                    -- require('hover.providers.gh_user')
                    -- require('hover.providers.jira')
                    require('hover.providers.dap')
                    require('hover.providers.fold_preview')
                    require('hover.providers.diagnostic')
                    -- require('hover.providers.man')
                    require('hover.providers.dictionary')
                end,
                preview_opts = {
                    border = 'single',
                },
                -- Whether the contents of a currently open hover window should be moved
                -- to a :h preview-window when pressing the hover keymap.
                preview_window = true,
                title = true,
                mouse_providers = { 'LSP', 'Diagnostic' },
                mouse_delay = 1000,
            })

            -- Setup keymaps
            vim.keymap.set('n', 'K', require('hover').hover, { desc = 'hover.nvim' })
            vim.keymap.set('n', 'gK', require('hover').hover_select, { desc = 'hover.nvim (select)' })
            vim.keymap.set('n', '<C-p>', function()
                require('hover').hover_switch('previous')
            end, { desc = 'hover.nvim (previous source)' })
            vim.keymap.set('n', '<C-n>', function()
                require('hover').hover_switch('next')
            end, { desc = 'hover.nvim (next source)' })

            -- Mouse support
            vim.keymap.set('n', '<MouseMove>', require('hover').hover_mouse, { desc = 'hover.nvim (mouse)' })
            vim.o.mousemoveevent = true
        end,
    },
}
