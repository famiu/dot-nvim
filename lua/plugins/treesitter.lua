return {
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
        main = 'nvim-treesitter.configs',
        config = function(_, opts)
            require('nvim-treesitter.install').compilers = { 'cl', 'clang', 'gcc' }
            require('nvim-treesitter.configs').setup(opts)
        end,
        opts = {
            ensure_installed = {
                'c',
                'cpp',
                'cmake',
                'swift',
                'rust',
                'python',
                'lua',
                'vim',
                'javascript',
                'typescript',
                'html',
                'css',
                'svelte',
                'bash',
                'json',
                'toml',
                'yaml',
                'markdown',
                'latex',
                'vimdoc',
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
