return {
    {
        'nvim-telescope/telescope.nvim',
        lazy = true,
        dependencies = 'nvim-lua/plenary.nvim',

        init = function()
            local keymap = vim.keymap

            keymap.set('n', '<Leader>ff', function() require('telescope.builtin').find_files() end)
            keymap.set('n', '<Leader>fg', function()
                require('telescope').extensions.live_grep_args.live_grep_args()
            end)
            keymap.set('n', '<Leader>fh', function() require('telescope.builtin').help_tags() end)
            keymap.set('n', '<Leader>ft', function() require('telescope.builtin').treesitter() end)
            keymap.set('n', '<Leader>fd', function() require('telescope.builtin').diagnostics() end)
            keymap.set('n', '<Leader>fo', function() require('telescope.builtin').oldfiles() end)
            keymap.set('n', '<Leader>qf', function() require('telescope.builtin').quickfix() end)
        end,

        -- `opts` is not used because telescope needs to be loaded prior to the config being evaluated.
        config = function()
            local ts_actions = require('telescope.actions')
            local lga_actions = require('telescope-live-grep-args.actions')

            require('telescope').setup {
                defaults = {
                    cache_picker = false,
                    mappings = {
                        i = {
                            ['<C-Down>'] = ts_actions.cycle_history_next,
                            ['<C-Up>'] = ts_actions.cycle_history_prev,
                        },
                    }
                },
                pickers = {
                    buffers = {
                        theme = 'ivy'
                    }
                },
                extensions = {
                    ['ui-select'] = {
                        require('telescope.themes').get_dropdown {
                        }
                    },
                    live_grep_args = {
                        auto_quoting = true,
                        mappings = {
                            i = {
                                ['<C-k>'] = lga_actions.quote_prompt(),
                            },
                        },
                    },
                }
            }

            pcall(require('telescope').load_extension, 'fzf')
            require('telescope').load_extension('ui-select')
            require('telescope').load_extension('smart_history')
        end,
    },

    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        dependencies = 'nvim-telescope/telescope.nvim',
    },

    {
        'nvim-telescope/telescope-ui-select.nvim',
        dependencies = 'nvim-telescope/telescope.nvim',
    },

    {
        'nvim-telescope/telescope-smart-history.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim', 'kkharji/sqlite.lua' },
    },

    {
        'nvim-telescope/telescope-live-grep-args.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim' }
    },
}
