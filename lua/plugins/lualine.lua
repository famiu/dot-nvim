return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'kyazdani42/nvim-web-devicons',
        'SmiteshP/nvim-navic',
        'EdenEast/nightfox.nvim'  -- Colorscheme is needed for Lualine theme
    },
    opts = {
        winbar = {
            lualine_c = { 'filename' },
            lualine_x = {
                function()
                    if require('nvim-navic').is_available() then
                        return require('nvim-navic').get_location()
                    else
                        return ''
                    end
                end
            }
        },
        inactive_winbar = {
            lualine_c = { 'filename' },
        }
    }
}
