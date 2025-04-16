return {
    {
        'zbirenbaum/copilot.lua',
        cmd = 'Copilot',
        event = 'InsertEnter',
        opts = {
            suggestion = {
                enabled = true,
                auto_trigger = true,
                hide_during_completion = true,
                debounce = 75,
                keymap = {
                    accept = '<M-l>',
                    accept_word = '<C-Right>',
                    accept_line = '<S-Right>',
                    next = '<M-]>',
                    prev = '<M-[>',
                    dismiss = '<C-]>',
                },
            },
            server_opts_overrides = {},
        },
    },
    {
        'yetone/avante.nvim',
        opts = {
            provider = 'copilot',
        },
        build = require('utilities.os').is_windows()
                and 'powershell -ExecutionPolicy Bypass -File Build -BuildFromSource false'
            or 'make',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-lua/plenary.nvim',
            'MunifTanjim/nui.nvim',
            'nvim-tree/nvim-web-devicons',
            'zbirenbaum/copilot.lua',
        },
    },
}
