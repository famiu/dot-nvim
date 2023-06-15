local M = {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects'
    },
    build = ':TSUpdate'
}

function M.config()
    require('nvim-treesitter.configs').setup {
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
                    [']d'] = '@conditional.outer',
                    [']o'] = '@loop.outer',
                    [']s'] = { query = '@scope', query_group = 'locals' },
                    [']z'] = { query = '@fold', query_group = 'folds' },
                },
                goto_next_end = {
                    [']A'] = '@parameter.inner',
                    [']M'] = '@function.outer',
                    [']['] = '@class.outer',
                    [']D'] = '@conditional.outer',
                    [']O'] = '@loop.outer',
                    [']S'] = { query = '@scope', query_group = 'locals' },
                    [']Z'] = { query = '@fold', query_group = 'folds' },
                },
                goto_previous_start = {
                    ['[a'] = '@parameter.inner',
                    ['[m'] = '@function.outer',
                    ['[['] = '@class.outer',
                    ['[d'] = '@conditional.outer',
                    ['[o'] = '@loop.outer',
                    ['[s'] = { query = '@scope', query_group = 'locals' },
                    ['[z'] = { query = '@fold', query_group = 'folds' },
                },
                goto_previous_end = {
                    ['[A'] = '@parameter.inner',
                    ['[M'] = '@function.outer',
                    ['[]'] = '@class.outer',
                    ['[D'] = '@conditional.outer',
                    ['[O'] = '@loop.outer',
                    ['[S'] = { query = '@scope', query_group = 'locals' },
                    ['[Z'] = { query = '@fold', query_group = 'folds' },
                },
                goto_next = {
                },
                goto_previous = {
                }
            },
        },
    }
end

 return M
