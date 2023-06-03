return {
    'folke/noice.nvim',
    dependencies = {
        'MunifTanjim/nui.nvim',
        'rcarriga/nvim-notify'
    },
    opts = {
        lsp = {
            override = {
                ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                ['vim.lsp.util.stylize_markdown'] = true,
                ['cmp.entry.get_documentation'] = true,
            },
            hover = { enabled = false },
            signature = { enabled = false },
        },
        presets = {
            bottom_search = true, -- use a classic bottom cmdline for search
            command_palette = false, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = true, -- add a border to hover docs and signature help
        },
        views = {
            cmdline_popup = {
                position = {
                    row = '50%',
                    col = '50%',
                },
                size = {
                    min_width = 60,
                    width = 'auto',
                    height = 'auto',
                },
            },
            popupmenu = {
                relative = 'editor',
                position = {
                    row = '63%',
                    col = '50%',
                },
                size = {
                    width = 60,
                    height = 10,
                },
                border = {
                    style = 'rounded',
                    padding = { 0, 1 },
                },
                win_options = {
                    winhighlight = { Normal = 'Normal', FloatBorder = 'NoiceCmdlinePopupBorder' },
                },
            },
        },
    }
}
