return {
    'ibhagwan/fzf-lua',
    -- optional for icon support
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = { 'FzfLua' },
    keys = {
        {
            '<Leader>ff',
            function()
                require('fzf-lua').files()
            end,
            desc = 'FzfLua find files',
        },
        {
            '<Leader>fF',
            function()
                require('fzf-lua').git_files()
            end,
            desc = 'FzfLua find Git files',
        },
        {
            '<Leader>fb',
            function()
                require('fzf-lua').buffers()
            end,
            desc = 'FzfLua find buffer',
        },
        {
            '<Leader>fg',
            function()
                require('fzf-lua').live_grep()
            end,
            desc = 'FzfLua live grep',
        },
        {
            '<Leader>fk',
            function()
                require('fzf-lua').keymaps()
            end,
            desc = 'FzfLua find keymaps',
        },
        {
            '<Leader>fh',
            function()
                require('fzf-lua').help_tags()
            end,
            desc = 'FzfLua find help tags',
        },
        {
            '<Leader>fd',
            function()
                require('fzf-lua').diagnostics()
            end,
            desc = 'FzfLua diagnostics',
        },
        {
            '<Leader>fo',
            function()
                require('fzf-lua').oldfiles()
            end,
            desc = 'FzfLua find oldfiles',
        },
        {
            '<Leader>fv',
            function()
                require('fzf-lua').files({
                    cwd = vim.fn.stdpath('config'),
                })
            end,
            desc = 'Find Neovim config file',
        },
        {
            '<Leader>fq',
            function()
                require('fzf-lua').quickfix()
            end,
            desc = 'FzfLua quickfix',
        },
        {
            '<Leader>/',
            function()
                require('fzf-lua').lgrep_curbuf()
            end,
            desc = 'FzfLua current buffer',
        },
        {
            '<Leader>w',
            function()
                require('fzf-lua').projects()
            end,
            desc = 'FzfLua project',
        },
        {
            '<Leader>fs',
            function()
                require('fzf-lua').lsp_workspace_symbols()
            end,
            desc = '[f]ind dynamic workspace [s]ymbols',
        },
        {
            '<Leader>fS',
            function()
                require('fzf-lua').lsp_document_symbols()
            end,
            desc = '[f]ind document [S]ymbols',
        },
    },
    config = function()
        local actions = require('fzf-lua.actions')

        require('fzf-lua').setup({
            'default-title',
            fzf_opts = {
                ['--layout'] = 'default',
            },
            files = {
                fzf_opts = {
                    ['--history'] = vim.fn.stdpath('data') .. '/fzf-lua-files-history',
                },
            },
            grep = {
                fzf_opts = {
                    ['--history'] = vim.fn.stdpath('data') .. '/fzf-lua-grep-history',
                },
                actions = {
                    ['ctrl-q'] = {
                        fn = actions.file_edit_or_qf,
                        prefix = 'select-all+',
                    },
                },
            },
        })
    end,
}
