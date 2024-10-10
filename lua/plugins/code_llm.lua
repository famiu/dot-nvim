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
                    accept_word = false,
                    accept_line = false,
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
            -- auto_suggestions_provider = 'copilot',
            -- behaviour = {
            --     auto_suggestions = true,
            -- },
        },
        build = require('utilities.os').is_windows()
                and 'powershell -ExecutionPolicy Bypass -File Build -BuildFromSource false'
            or 'make',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'stevearc/dressing.nvim',
            'nvim-lua/plenary.nvim',
            'MunifTanjim/nui.nvim',
            'nvim-tree/nvim-web-devicons',
            'zbirenbaum/copilot.lua', -- for providers='copilot'
        },
    },
}
