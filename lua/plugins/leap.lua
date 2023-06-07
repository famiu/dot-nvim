return {
    {
        'ggandor/leap.nvim',
        config = function() require('leap').add_default_mappings(true) end,
    },
    {
        'ggandor/leap-spooky.nvim',
        dependencies = 'ggandor/leap.nvim',
        config = true
    },
}
