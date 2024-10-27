return {
    'nvim-telescope/telescope.nvim',
    lazy = true,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-live-grep-args.nvim',
        'nvim-telescope/telescope-project.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
        },
    },
    event = 'LspAttach',
    cmd = { 'Telescope' },
    keys = {
        {
            '<Leader>ff',
            function()
                require('telescope.builtin').find_files()
            end,
            desc = 'Telescope find files',
        },
        {
            '<Leader>fF',
            function()
                require('telescope.builtin').git_files()
            end,
            desc = 'Telescope find Git files',
        },
        {
            '<Leader>fb',
            function()
                require('telescope.builtin').buffers()
            end,
            desc = 'Telescope find buffer',
        },
        {
            '<Leader>fg',
            function()
                require('telescope').extensions.live_grep_args.live_grep_args()
            end,
            desc = 'Telescope live grep with args',
        },
        {
            '<Leader>fk',
            function()
                require('telescope.builtin').keymaps()
            end,
            desc = 'Telescope find keymaps',
        },
        {
            '<Leader>fh',
            function()
                require('telescope.builtin').help_tags()
            end,
            desc = 'Telescope find help tags',
        },
        {
            '<Leader>fd',
            function()
                require('telescope.builtin').diagnostics()
            end,
            desc = 'Telescope diagnostics',
        },
        {
            '<Leader>fo',
            function()
                require('telescope.builtin').oldfiles()
            end,
            desc = 'Telescope find oldfiles',
        },
        {
            '<Leader>fv',

            function()
                require('telescope.builtin').find_files({
                    cwd = vim.fn.stdpath('config'),
                })
            end,

            desc = 'Find Neovim config file',
        },
        {
            '<Leader>qf',
            function()
                require('telescope.builtin').quickfix()
            end,
            desc = 'Telescope quickfix',
        },
        {
            '<Leader>/',
            function()
                local dropdown = require('telescope.themes').get_dropdown({ previewer = false })
                require('telescope.builtin').current_buffer_fuzzy_find(dropdown)
            end,
            desc = 'Telescope current buffer',
        },
        {
            '<C-p>',
            function()
                require('telescope').extensions.project.project()
            end,
            desc = 'Telescope project',
        },
    },

    -- `opts` is not used because telescope needs to be loaded prior to the config being evaluated.
    config = function()
        local ts_actions = require('telescope.actions')
        local lga_actions = require('telescope-live-grep-args.actions')
        local project_actions = require('telescope._extensions.project.actions')

        require('telescope').setup({
            defaults = {
                cache_picker = false,
                mappings = {
                    i = {
                        ['<C-Down>'] = ts_actions.cycle_history_next,
                        ['<C-Up>'] = ts_actions.cycle_history_prev,
                    },
                },
            },
            pickers = {
                buffers = {
                    theme = 'ivy',
                },
            },
            extensions = {
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
                        vim.uv.os_homedir() .. '/Documents/Dev',
                    },
                    cd_scope = { 'window' },
                    theme = 'dropdown',
                    on_project_selected = function(prompt_bufnr)
                        -- Do anything you want in here. For example:
                        project_actions.change_working_directory(prompt_bufnr, false)
                        require('telescope.builtin').find_files()
                    end,
                },
            },
        })

        pcall(require('telescope').load_extension, 'fzf')
        require('telescope').load_extension('project')
    end,
}
