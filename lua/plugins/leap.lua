return {
    {
        'ggandor/leap.nvim',
        config = function()
            -- Make leap bidirectional
            vim.keymap.set({ 'n', 'v', 'o' }, 's', function ()
                require('leap').leap {
                    target_windows = { vim.api.nvim_get_current_win() }
                }
            end)
        end,
    },
    {
        'ggandor/leap-spooky.nvim',
        dependencies = 'ggandor/leap.nvim',
        config = true
    },
    {
        'ggandor/flit.nvim',
        dependencies = { 'ggandor/leap.nvim', 'tpope/vim-repeat' },
        opts = {
            labeled_modes = 'nvo',
        },
    },
}
