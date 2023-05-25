return {
    {
        'nvim-telescope/telescope.nvim',
        lazy = true,
        dependencies = 'nvim-lua/plenary.nvim',

        init = function()
            local keymap = vim.keymap

            keymap.set('n', '<Leader>ff', function() require('telescope.builtin').find_files() end, {})
            keymap.set('n', '<Leader>fg', function() require('telescope.builtin').live_grep() end, {})
            keymap.set('n', '<Leader>fb', function() require('telescope.builtin').buffers() end, {})
            keymap.set('n', '<Leader>fh', function() require('telescope.builtin').help_tags() end, {})
            keymap.set('n', '<Leader>ft', function() require('telescope.builtin').treesitter() end, {})
            keymap.set('n', '<Leader>fd', function() require('telescope.builtin').diagnostics() end, {})
            keymap.set('n', '<Leader>fo', function() require('telescope.builtin').oldfiles() end, {})
            keymap.set('n', '<Leader>qf', function() require('telescope.builtin').quickfix() end, {})
        end,

        -- `opts` is not used because telescope needs to be loaded prior to the config being evaluated.
        config = function()
            require('telescope').setup {
                defaults = {
                    cache_picker = false,
                    mappings = {
                        i = {
                            ['<C-Down>'] = require('telescope.actions').cycle_history_next,
                            ['<C-Up>'] = require('telescope.actions').cycle_history_prev,
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
                    }
                }
            }
        end,
    },

    {
        'nvim-telescope/telescope-ui-select.nvim',
        dependencies = 'nvim-telescope/telescope.nvim',
        config = function() require('telescope').load_extension('ui-select') end
    },

    {
        'nvim-telescope/telescope-smart-history.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim', 'kkharji/sqlite.lua' },

        cond = function()
            -- Notify if libsqlite is not installed
            if vim.fn.system('/usr/bin/env ldconfig -p | grep libsqlite3.so') == "" then
                vim.notify_once(
                    "libsqlite not found in system. Telescope smart history needs libsqlite to work",
                    vim.log.levels.INFO
                )

                return false
            end

            return true
        end,

        config = function() require('telescope').load_extension('smart_history') end
    },
}
