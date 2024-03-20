return {
    'EdenEast/nightfox.nvim',
    opts = {
        options = {
            styles = {
                keywords = 'bold',
            },
        },
    },
    config = function(_, opts)
        vim.g.testvar = opts
        require('nightfox').setup(opts)
        vim.cmd.colorscheme('carbonfox')
    end,
}
