return {
    -- Colorscheme
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000,
        opts = {
            transparent_background = true,
            integrations = {
                blink_cmp = true,
                diffview = true,
                dropbar = true,
                harpoon = true,
                mason = true,
                noice = true,
                snacks = {
                    enabled = true,
                },
            },
        },
        config = function(_, opts)
            require('catppuccin').setup(opts)
            vim.cmd.colorscheme('catppuccin')
        end,
    },
    {
        'luukvbaal/statuscol.nvim',
        config = function()
            local builtin = require('statuscol.builtin')

            require('statuscol').setup({
                segments = {
                    { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
                    {
                        sign = {
                            namespace = { 'diagnostic' },
                            maxwidth = 1,
                            colwidth = 2,
                            auto = true,
                            foldclosed = true,
                        },
                        click = 'v:lua.ScSa',
                    },
                    { text = { builtin.lnumfunc }, click = 'v:lua.ScLa' },
                    {
                        sign = {
                            name = { '.*' },
                            text = { '.*' },
                            maxwidth = 2,
                            colwidth = 1,
                            auto = true,
                            foldclosed = true,
                        },
                        click = 'v:lua.ScSa',
                    },
                    {
                        sign = {
                            namespace = { 'gitsigns' },
                            fillchar = '│',
                            maxwidth = 1,
                            colwidth = 1,
                            wrap = true,
                            foldclosed = true,
                        },
                        click = 'v:lua.ScSa',
                    },
                },
            })
        end,
    },
    { 'yorickpeterse/nvim-pqf', opts = {} },
    {
        'mbbill/undotree',
        keys = {
            { '<Leader>u', '<CMD>UndotreeToggle<CR>' },
        },
    },
    {
        'folke/todo-comments.nvim',
        opts = {
            highlight = {
                pattern = { [[.*<(KEYWORDS)\s*:]], [[.*<(KEYWORDS)\s*\(\w+\)\s*:]] },
            },
            search = {
                pattern = [[\b(KEYWORDS)\s*(\(\w+\))?\s*:]],
            },
        },
    },
    {
        'lewis6991/hover.nvim',
        config = function()
            require('hover').setup({
                init = function()
                    -- Require providers
                    require('hover.providers.lsp')
                    require('hover.providers.gh')
                    -- require('hover.providers.gh_user')
                    -- require('hover.providers.jira')
                    require('hover.providers.dap')
                    require('hover.providers.fold_preview')
                    require('hover.providers.diagnostic')
                    -- require('hover.providers.man')
                    require('hover.providers.dictionary')
                end,
                preview_opts = {
                    border = 'single',
                },
                -- Whether the contents of a currently open hover window should be moved
                -- to a :h preview-window when pressing the hover keymap.
                preview_window = true,
                title = true,
                -- mouse_providers = { 'LSP', 'Diagnostic' },
                -- mouse_delay = 1000,
            })

            -- Setup keymaps
            vim.keymap.set('n', 'K', require('hover').hover, { desc = 'hover.nvim' })
            vim.keymap.set('n', 'gK', require('hover').hover_select, { desc = 'hover.nvim (select)' })
            vim.keymap.set('n', '<C-p>', function()
                require('hover').hover_switch('previous')
            end, { desc = 'hover.nvim (previous source)' })
            vim.keymap.set('n', '<C-n>', function()
                require('hover').hover_switch('next')
            end, { desc = 'hover.nvim (next source)' })

            -- Mouse support
            vim.keymap.set('n', '<MouseMove>', require('hover').hover_mouse, { desc = 'hover.nvim (mouse)' })
            vim.o.mousemoveevent = true
        end,
    },
}
