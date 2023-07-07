return {
    {
        'nvim-telescope/telescope.nvim',
        lazy = true,
        dependencies = 'nvim-lua/plenary.nvim',

        keys = {
            { '<Leader>ff', function() require('telescope.builtin').find_files() end },
            { '<Leader>fF', function() require('telescope.builtin').git_files() end },
            { '<Leader>fg', function() require('telescope').extensions.live_grep_args.live_grep_args() end },
            { '<Leader>fh', function() require('telescope.builtin').help_tags() end },
            { '<Leader>ft', function() require('telescope.builtin').treesitter() end },
            { '<Leader>fd', function() require('telescope.builtin').diagnostics() end },
            { '<Leader>fo', function() require('telescope.builtin').oldfiles() end },
            { '<Leader>qf', function() require('telescope.builtin').quickfix() end },
        },

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

            -- Telescope LSP mappings
            local augroup = vim.api.nvim_create_augroup('telescope-lsp', {})
            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'Telescope LSP keybindings',
                group = augroup,
                callback = function(args)
                    vim.keymap.set(
                        'n', '<Leader>fS',
                        function() require('telescope.builtin').lsp_document_symbols() end,
                        { buffer = args.buf }
                    )
                    vim.keymap.set(
                        'n', '<Leader>fs',
                        function() require('telescope.builtin').lsp_workspace_symbols() end,
                        { buffer = args.buf }
                    )
                end
            })
        end,
    },

    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        lazy = true,
        dependencies = 'nvim-telescope/telescope.nvim',
    },

    {
        'nvim-telescope/telescope-ui-select.nvim',
        lazy = true,
        dependencies = 'nvim-telescope/telescope.nvim',
    },

    {
        'nvim-telescope/telescope-smart-history.nvim',
        lazy = true,
        dependencies = { 'nvim-telescope/telescope.nvim', 'kkharji/sqlite.lua' },
    },

    {
        'nvim-telescope/telescope-live-grep-args.nvim',
        lazy = true,
        dependencies = { 'nvim-telescope/telescope.nvim' }
    },
}
