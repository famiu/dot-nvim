return {
    {
        'folke/flash.nvim',
        opts = {
            jump = {
                autojump = true,
            },
            label = {
                uppercase = false,
            },
            modes = {
                search = {
                    enabled = false,
                },
                char = {
                    jump_labels = function(_)
                        return vim.v.count == 0
                    end,
                },
            },
        },
        keys = {
            {
                '<CR>',
                mode = { 'n', 'x', 'o' },
                function()
                    -- default options: exact mode, multi window, all directions, with a backdrop
                    require('flash').jump()
                end,
                desc = 'Flash',
            },
            {
                '<S-CR>',
                mode = { 'n', 'x', 'o' },
                function()
                    require('flash').treesitter()
                end,
                desc = 'Flash Treesitter',
            },
            {
                'r',
                mode = 'o',
                function()
                    require('flash').remote()
                end,
                desc = 'Remote Flash',
            },
            {
                '<C-s>',
                mode = 'c',
                function()
                    require('flash').toggle()
                end,
                desc = 'Toggle Flash Search',
            },
            { 'f', mode = { 'n', 'x', 'o' } },
            { 'F', mode = { 'n', 'x', 'o' } },
            { 't', mode = { 'n', 'x', 'o' } },
            { 'T', mode = { 'n', 'x', 'o' } },
        },
        init = function()
            -- Unmap <CR> in quickfix and command-line windows
            local flash_unmap_augroup = vim.api.nvim_create_augroup('FlashUnmapCR', {})
            local flash_unmap_fn = function()
                vim.keymap.set('n', '<CR>', '<CR>', { buffer = 0 })
            end

            vim.api.nvim_create_autocmd('FileType', {
                pattern = 'qf',
                callback = flash_unmap_fn,
                group = flash_unmap_augroup,
                desc = 'Unmap <CR> for quickfix windows',
            })

            vim.api.nvim_create_autocmd('CmdwinEnter', {
                callback = flash_unmap_fn,
                group = flash_unmap_augroup,
                desc = 'Unmap <CR> for command-line windows',
            })
        end,
        config = function(_, opts)
            require('flash').setup(opts)

            -- Always toggle flash search jump labels off after entering cmdline
            -- So that the <C-s> keybind only applies for the current search
            vim.api.nvim_create_autocmd('CmdlineEnter', {
                callback = function(_)
                    if vim.v.event.cmdtype:match('[/?]') then
                        require('flash').toggle(false)
                    end
                end,
                group = vim.api.nvim_create_augroup('FlashCmdlineToggle', {}),
                desc = 'Toggle Flash search jump labels off when entering cmdline',
            })
        end,
    },
}
