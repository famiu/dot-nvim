return {
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            {
                'nvim-treesitter/nvim-treesitter-context',
                lazy = false,
                opts = {
                    max_lines = 20,
                    multiline_threshold = 3,
                    trim_scope = 'outer',
                    mode = 'cursor',
                },
                keys = {
                    {
                        '[l',
                        function()
                            require('treesitter-context').go_to_context(vim.v.count1)
                        end,
                        desc = 'Go up a context [l]evel',
                        silent = true,
                    },
                },
                config = function(_, opts)
                    vim.api.nvim_set_hl(0, 'TreesitterContextBottom', { sp = 'Grey', underline = true })
                    vim.api.nvim_set_hl(0, 'TreesitterContextLineNumber', { link = 'NormalFloat' })
                    require('treesitter-context').setup(opts)
                end,
            },
        },
        build = ':TSUpdate',
        main = 'nvim-treesitter.configs',
        init = function()
            vim.o.foldmethod = 'expr'
            vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
        end,
        config = function(_, opts)
            require('nvim-treesitter.install').compilers = { 'cl', 'clang', 'gcc' }
            require('nvim-treesitter.configs').setup(opts)
        end,
        opts = {
            ensure_installed = {
                'c',
                'lua',
                'vim',
                'vimdoc',
                'cpp',
                'cmake',
                'python',
                'rust',
                'bash',
                'toml',
                'latex',
                'regex',
            },
            highlight = {
                enable = true,
                disable = { 'latex' },
            },
            textobjects = {
                select = {
                    enable = true,
                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,
                    keymaps = {
                        ['aa'] = '@parameter.outer',
                        ['ia'] = '@parameter.inner',
                        ['af'] = '@function.outer',
                        ['if'] = '@function.inner',
                        ['ac'] = '@class.outer',
                        ['ic'] = '@class.inner',
                        ['ad'] = '@conditional.outer',
                        ['id'] = '@conditional.inner',
                        ['ao'] = '@loop.outer',
                        ['io'] = '@loop.inner',
                        ['as'] = { query = '@scope', query_group = 'locals' },
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ['<leader>a'] = '@parameter.inner',
                    },
                    swap_previous = {
                        ['<leader>A'] = '@parameter.inner',
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        [']a'] = '@parameter.inner',
                        [']m'] = '@function.outer',
                        [']]'] = '@class.outer',
                        [']i'] = '@conditional.outer',
                        [']o'] = '@loop.outer',
                        [']s'] = { query = '@scope', query_group = 'locals' },
                        [']z'] = { query = '@fold', query_group = 'folds' },
                    },
                    goto_next_end = {
                        [']A'] = '@parameter.inner',
                        [']M'] = '@function.outer',
                        [']['] = '@class.outer',
                        [']I'] = '@conditional.outer',
                        [']O'] = '@loop.outer',
                        [']S'] = { query = '@scope', query_group = 'locals' },
                        [']Z'] = { query = '@fold', query_group = 'folds' },
                    },
                    goto_previous_start = {
                        ['[a'] = '@parameter.inner',
                        ['[m'] = '@function.outer',
                        ['[['] = '@class.outer',
                        ['[i'] = '@conditional.outer',
                        ['[o'] = '@loop.outer',
                        ['[s'] = { query = '@scope', query_group = 'locals' },
                        ['[z'] = { query = '@fold', query_group = 'folds' },
                    },
                    goto_previous_end = {
                        ['[A'] = '@parameter.inner',
                        ['[M'] = '@function.outer',
                        ['[]'] = '@class.outer',
                        ['[I'] = '@conditional.outer',
                        ['[O'] = '@loop.outer',
                        ['[S'] = { query = '@scope', query_group = 'locals' },
                        ['[Z'] = { query = '@fold', query_group = 'folds' },
                    },
                    goto_next = {},
                    goto_previous = {},
                },
            },
        },
    },
}
