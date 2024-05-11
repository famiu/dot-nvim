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
