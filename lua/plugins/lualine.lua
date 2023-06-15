return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'SmiteshP/nvim-navic',
        'EdenEast/nightfox.nvim', -- Colorscheme is needed for Lualine theme
        'folke/noice.nvim',       -- For mode
    },
    config = function()
        local noice = require('noice')
        local navic = require('nvim-navic')

        require('lualine').setup {
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { 'filename' },
                lualine_x = {
                    {
                        noice.api.status.mode.get,
                        cond = noice.api.status.mode.has,
                        color = { fg = '#ff9e64' },
                    },
                    'encoding',
                    'fileformat',
                    'filetype'
                },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {}
            },
            winbar = {
                lualine_c = { { 'filename', path = 1 } },
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
                lualine_c = { { 'filename', path = 1 } },
            },
            extensions = {
                'man',
                'quickfix',
                'fugitive',
                'lazy',
                'nvim-dap-ui',
                'toggleterm',
            }
        }
    end
}
