local api = vim.api

return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'folke/noice.nvim',
        'SmiteshP/nvim-navic',
    },
    opts = {
        options = {
            theme = 'ayu_dark',
            component_separators = { left = '╱', right = '╲' },
            section_separators = { left = '', right = '' },
            disabled_filetypes = {
                winbar = {
                    'dapui_watches',
                    'dapui_breakpoints',
                    'dapui_scopes',
                    'dapui_console',
                    'dapui_stacks',
                    'dap-repl',
                },
            },
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff', 'diagnostics' },
            lualine_c = { 'filename' },
            lualine_x = {
                {
                    function(...)
                        require('noice').api.status.mode.get(...)
                    end,
                    cond = function(...)
                        require('noice').api.status.mode.has(...)
                    end,
                    color = { fg = '#ff9e64' },
                },
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
        winbar = {
            lualine_c = { { 'filename', path = 3 } },
            lualine_x = {
                function()
                    if require('nvim-navic').is_available() then
                        return require('nvim-navic').get_location()
                    else
                        return ''
                    end
                end,
            },
        },
        inactive_winbar = {
            lualine_c = { { 'filename', path = 3 } },
        },
        extensions = {
            'man',
            'quickfix',
            'fugitive',
            'lazy',
            'nvim-dap-ui',
            'toggleterm',
        },
    },
    config = function(_, opts)
        api.nvim_create_autocmd('LspAttach', {
            desc = 'LSP configuration',
            group = api.nvim_create_augroup('nvim-navic', {}),
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                assert(client ~= nil)

                if client.server_capabilities.documentSymbolProvider then
                    require('nvim-navic').attach(client, args.buf)
                end
            end,
        })

        require('lualine').setup(opts)
    end,
}
