return {
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        lazy = false,
        build = ':TSUpdate',
        config = function()
            local ts = require('nvim-treesitter')
            require('nvim-treesitter.install').compilers = { 'cl', 'clang', 'gcc' }

            local parsers = {
                'c',
                'cpp',
                'cmake',
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
                'markdown_inline',
                'vimdoc',
                'regex',
            }
            ts.install(parsers)

            local filetypes = {}
            for _, parser in ipairs(parsers) do
                local parser_fts = vim.treesitter.language.get_filetypes(parser)
                vim.list_extend(filetypes, parser_fts)
            end

            vim.api.nvim_create_autocmd('FileType', {
                pattern = filetypes,
                callback = function(args)
                    local ft = vim.bo[args.buf].filetype
                    -- Disable Treesitter indent for (La)TeX.
                    if ft == 'latex' or ft == 'tex' then return end

                    vim.treesitter.start(args.buf)
                    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })

            vim.wo.foldmethod = 'expr'
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        end,
    },

    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = 'main',
        dependencies = {
            { 'nvim-treesitter/nvim-treesitter', branch = 'main' },
        },
        init = function()
            vim.g.no_plugin_maps = true
        end,
        config = function()
            require('nvim-treesitter-textobjects').setup {
                select = {
                    lookahead = true,
                    include_surrounding_whitespace = false,
                },
                move = {
                    set_jumps = true, -- whether to set jumps in the jumplist
                },
            }

            local select = require('nvim-treesitter-textobjects.select')
            local move   = require('nvim-treesitter-textobjects.move')
            local swap   = require('nvim-treesitter-textobjects.swap')

            local sel = function(query) return function() select.select_textobject(query, 'textobjects') end end
            vim.keymap.set({ 'x', 'o' }, 'aa', sel('@parameter.outer'))
            vim.keymap.set({ 'x', 'o' }, 'ia', sel('@parameter.inner'))
            vim.keymap.set({ 'x', 'o' }, 'af', sel('@function.outer'))
            vim.keymap.set({ 'x', 'o' }, 'if', sel('@function.inner'))
            vim.keymap.set({ 'x', 'o' }, 'ac', sel('@class.outer'))
            vim.keymap.set({ 'x', 'o' }, 'ic', sel('@class.inner'))
            vim.keymap.set({ 'x', 'o' }, 'ad', sel('@conditional.outer'))
            vim.keymap.set({ 'x', 'o' }, 'id', sel('@conditional.inner'))
            vim.keymap.set({ 'x', 'o' }, 'ao', sel('@loop.outer'))
            vim.keymap.set({ 'x', 'o' }, 'io', sel('@loop.inner'))
            vim.keymap.set({ 'x', 'o' }, 'as', function()
                select.select_textobject('@local.scope', 'locals')
            end)

            vim.keymap.set('n', '<leader>a', function()
                swap.swap_next('@parameter.inner', 'textobjects')
            end)
            vim.keymap.set('n', '<leader>A', function()
                swap.swap_previous('@parameter.inner', 'textobjects')
            end)

            -- Automatically jump forward to textobj, similar to targets.vim
            vim.keymap.set({ 'n', 'x', 'o' }, ']a', function() move.goto_next_start('@parameter.inner', 'textobjects') end)
            vim.keymap.set({ 'n', 'x', 'o' }, ']m', function() move.goto_next_start('@function.outer',  'textobjects') end)
            vim.keymap.set({ 'n', 'x', 'o' }, ']]', function() move.goto_next_start('@class.outer',     'textobjects') end)
            vim.keymap.set({ 'n', 'x', 'o' }, ']i', function() move.goto_next_start('@conditional.outer','textobjects') end)
            vim.keymap.set({ 'n', 'x', 'o' }, ']o', function() move.goto_next_start('@loop.outer',      'textobjects') end)
            vim.keymap.set({ 'n', 'x', 'o' }, ']s', function() move.goto_next_start('@local.scope',     'locals') end)
            vim.keymap.set({ 'n', 'x', 'o' }, ']z', function() move.goto_next_start('@fold',            'folds') end)

            vim.keymap.set({ 'n', 'x', 'o' }, ']A', function() move.goto_next_end('@parameter.inner',   'textobjects') end)
            vim.keymap.set({ 'n', 'x', 'o' }, ']M', function() move.goto_next_end('@function.outer',    'textobjects') end)
            vim.keymap.set({ 'n', 'x', 'o' }, '][', function() move.goto_next_end('@class.outer',       'textobjects') end)
            vim.keymap.set({ 'n', 'x', 'o' }, ']I', function() move.goto_next_end('@conditional.outer', 'textobjects') end)
            vim.keymap.set({ 'n', 'x', 'o' }, ']O', function() move.goto_next_end('@loop.outer',        'textobjects') end)
            vim.keymap.set({ 'n', 'x', 'o' }, ']S', function() move.goto_next_end('@local.scope',       'locals') end)
            vim.keymap.set({ 'n', 'x', 'o' }, ']Z', function() move.goto_next_end('@fold',              'folds') end)

            vim.keymap.set({ 'n', 'x', 'o' }, '[a', function() move.goto_previous_start('@parameter.inner',   'textobjects') end)
            vim.keymap.set({ 'n', 'x', 'o' }, '[m', function() move.goto_previous_start('@function.outer',    'textobjects') end)
            vim.keymap.set({ 'n', 'x', 'o' }, '[[', function() move.goto_previous_start('@class.outer',       'textobjects') end)
            vim.keymap.set({ 'n', 'x', 'o' }, '[i', function() move.goto_previous_start('@conditional.outer', 'textobjects') end)
            vim.keymap.set({ 'n', 'x', 'o' }, '[o', function() move.goto_previous_start('@loop.outer',        'textobjects') end)
            vim.keymap.set({ 'n', 'x', 'o' }, '[s', function() move.goto_previous_start('@local.scope',       'locals') end)
            vim.keymap.set({ 'n', 'x', 'o' }, '[z', function() move.goto_previous_start('@fold',              'folds') end)

            vim.keymap.set({ 'n', 'x', 'o' }, '[A', function() move.goto_previous_end('@parameter.inner',   'textobjects') end)
            vim.keymap.set({ 'n', 'x', 'o' }, '[M', function() move.goto_previous_end('@function.outer',    'textobjects') end)
            vim.keymap.set({ 'n', 'x', 'o' }, '[]', function() move.goto_previous_end('@class.outer',       'textobjects') end)
            vim.keymap.set({ 'n', 'x', 'o' }, '[I', function() move.goto_previous_end('@conditional.outer', 'textobjects') end)
            vim.keymap.set({ 'n', 'x', 'o' }, '[O', function() move.goto_previous_end('@loop.outer',        'textobjects') end)
            vim.keymap.set({ 'n', 'x', 'o' }, '[S', function() move.goto_previous_end('@local.scope',       'locals') end)
            vim.keymap.set({ 'n', 'x', 'o' }, '[Z', function() move.goto_previous_end('@fold',              'folds') end)

            local repeat_move = require('nvim-treesitter-textobjects.repeatable_move')
            vim.keymap.set({ 'n', 'x', 'o' }, ';', repeat_move.repeat_last_move_next)
            vim.keymap.set({ 'n', 'x', 'o' }, ',', repeat_move.repeat_last_move_previous)
            vim.keymap.set({ 'n', 'x', 'o' }, 'f', repeat_move.builtin_f_expr, { expr = true })
            vim.keymap.set({ 'n', 'x', 'o' }, 'F', repeat_move.builtin_F_expr, { expr = true })
            vim.keymap.set({ 'n', 'x', 'o' }, 't', repeat_move.builtin_t_expr, { expr = true })
            vim.keymap.set({ 'n', 'x', 'o' }, 'T', repeat_move.builtin_T_expr, { expr = true })
        end,
    },
}
