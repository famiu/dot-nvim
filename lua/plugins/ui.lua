return {
    { 'yorickpeterse/nvim-pqf', opts = {} },
    { 'stevearc/dressing.nvim', opts = {} },
    {
        'mbbill/undotree',
        keys = {
            { '<Leader>u', '<CMD>UndotreeToggle<CR>' },
        },
    },
    {
        'echasnovski/mini.hipatterns',
        config = function()
            local hipatterns = require('mini.hipatterns')

            hipatterns.setup({
                highlighters = {
                    fixme = { pattern = 'FIXME%(%w+%)?:', group = 'MiniHipatternsFixme' },
                    hack = { pattern = 'HACK%(%w+%)?:', group = 'MiniHipatternsHack' },
                    todo = { pattern = 'TODO%(%w+%)?:', group = 'MiniHipatternsTodo' },
                    note = { pattern = 'NOTE%(%w+%)?:', group = 'MiniHipatternsNote' },
                    trailing_space = { pattern = '%s+$', group = 'Error' },
                    hex_color = hipatterns.gen_highlighter.hex_color(),
                },
            })
        end,
    },
    { 'j-hui/fidget.nvim', opts = {} },
    {
        'rcarriga/nvim-notify',
        config = function()
            vim.notify = require('notify')
        end,
    },
}
