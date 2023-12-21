return {
    {
        'nvim-telescope/telescope.nvim',
        lazy = true,
        dependencies = 'nvim-lua/plenary.nvim',
        event = 'LspAttach',
        cmds = { 'Telescope' },
        keys = {
            {
                '<Leader>ff',
                function() require('telescope.builtin').find_files() end,
                desc = 'Telescope find files',
            },
            {
                '<Leader>fF',
                function() require('telescope.builtin').git_files() end,
                desc = 'Telescope find Git files',
            },
            {
                '<Leader>fg',
                function() require('telescope').extensions.live_grep_args.live_grep_args() end,
                desc = 'Telescope live grep with args',
            },
            {
                '<Leader>fh',
                function() require('telescope.builtin').help_tags() end,
                desc = 'Telescope find help tags',
            },
            {
                '<Leader>fd',
                function() require('telescope.builtin').diagnostics() end,
                desc = 'Telescope diagnostics',
            },
            {
                '<Leader>fo',
                function() require('telescope.builtin').oldfiles() end,
                desc = 'Telescope find oldfiles',
            },
            {
                '<Leader>qf',
                function() require('telescope.builtin').quickfix() end,
                desc = 'Telescope quickfix',
            },
            {
                '<C-p>',
                function() require('telescope').extensions.project.project() end,
                desc = 'Telescope project',
            },
        },

        -- `opts` is not used because telescope needs to be loaded prior to the config being evaluated.
        config = function()
            local ts_actions = require('telescope.actions')
            local lga_actions = require('telescope-live-grep-args.actions')
            local project_actions = require("telescope._extensions.project.actions")

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
                    project = {
                        base_dirs = {
                            '~/dev',
                        },
                        theme = 'dropdown',
                        on_project_selected = function(prompt_bufnr)
                            -- Do anything you want in here. For example:
                            project_actions.change_working_directory(prompt_bufnr, false)
                            require('telescope.builtin').find_files()
                        end,
                    }
                },
            }

            pcall(require('telescope').load_extension, 'fzf')
            require('telescope').load_extension('ui-select')
            require('telescope').load_extension('smart_history')
            require('telescope').load_extension('project')
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
        dependencies = 'nvim-telescope/telescope.nvim',
    },

    {
        'nvim-telescope/telescope-project.nvim',
        lazy = true,
        dependencies = 'nvim-telescope/telescope.nvim',
    },
}
