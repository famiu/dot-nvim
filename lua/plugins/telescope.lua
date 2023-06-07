return {
    {
        'nvim-telescope/telescope.nvim',
        lazy = true,
        dependencies = 'nvim-lua/plenary.nvim',

        init = function()
            local keymap = vim.keymap
            local ts_builtin = require('telescope.builtin')
            local ts_extensions = require('telescope').extensions

            keymap.set('n', '<Leader>ff', function() ts_builtin.find_files() end, {})
            keymap.set('n', '<Leader>fg', function() ts_extensions.live_grep_args.live_grep_args() end, {})
            keymap.set('n', '<Leader>fb', function() ts_builtin.buffers() end, {})
            keymap.set('n', '<Leader>fh', function() ts_builtin.help_tags() end, {})
            keymap.set('n', '<Leader>ft', function() ts_builtin.treesitter() end, {})
            keymap.set('n', '<Leader>fd', function() ts_builtin.diagnostics() end, {})
            keymap.set('n', '<Leader>fo', function() ts_builtin.oldfiles() end, {})
            keymap.set('n', '<Leader>qf', function() ts_builtin.quickfix() end, {})
        end,

        -- `opts` is not used because telescope needs to be loaded prior to the config being evaluated.
        config = function()
            local ts_actions = require('telescope.actions')
            local lga_actions = require("telescope-live-grep-args.actions")

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
                                ["<C-k>"] = lga_actions.quote_prompt(),
                                ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                            },
                        },
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

    {
        'nvim-telescope/telescope-live-grep-args.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim' }
    }
}
