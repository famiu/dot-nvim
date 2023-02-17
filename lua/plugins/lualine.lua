local navic = require('nvim-navic')

require('lualine').setup {
    winbar = {
        lualine_c = { 'filename' },
        lualine_x = {
            function()
                if navic.is_available() then
                    return navic.get_location()
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
