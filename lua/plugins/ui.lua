return {
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
    { 'stevearc/dressing.nvim', opts = {} },
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
    { 'brenoprata10/nvim-highlight-colors', opts = {} },
    { 'j-hui/fidget.nvim', opts = {} },
    {
        'rcarriga/nvim-notify',
        config = function()
            vim.notify = require('notify')
        end,
    },
}
