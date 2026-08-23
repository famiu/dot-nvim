require('lualine').setup({
    options = {
        theme = 'catppuccin-nvim',
        component_separators = { left = '╱', right = '╲' },
        section_separators = { left = '', right = '' },
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename', 'searchcount' },
        lualine_x = {
            'encoding',
            'fileformat',
            'filetype',
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
    },
    extensions = {
        'man',
        'quickfix',
        'fugitive',
        'nvim-dap-ui',
        'toggleterm',
    },
})
