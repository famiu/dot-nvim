local keymap = vim.keymap

return {
    {
        'EdenEast/nightfox.nvim',
        opts = {
            options = {
                styles = {
                    keywords = 'bold',
                },
            },
        },
        config = function(_, opts)
            vim.g.testvar = opts
            require('nightfox').setup(opts)
            vim.cmd.colorscheme('carbonfox')
        end,
    },
    {
        'famiu/bufdelete.nvim',
        name = 'bufdelete',
        dev = true,
        init = function() keymap.set('n', '<Leader>x', 'Bdelete', { silent = true }) end,
        cmd = { 'Bdelete', 'Bwipeout' },
    },
    { 'numToStr/Comment.nvim', opts = {} },
    { 'echasnovski/mini.align', opts = {} },
    {
        'tpope/vim-surround',
        init = function()
            -- Disable surround mappings to prevent conflict with flash.nvim
            vim.g.surround_no_mappings = 1
        end,
        keys = {
            { 'ds', '<Plug>Dsurround' },
            { 'cs', '<Plug>Csurround' },
            { 'cS', '<Plug>CSurround' },
            { 'ys', '<Plug>Ysurround' },
            { 'yS', '<Plug>YSurround' },
            { 'yss', '<Plug>Yssurround' },
            { 'ySs', '<Plug>YSsurround' },
            { 'ySS', '<Plug>YSsurround' },
            { 'gs', '<Plug>VSurround', mode = 'x' },
            { 'gS', '<Plug>VgSurround', mode = 'x' },
        },
    },
    'tpope/vim-sleuth',
    { 'mbbill/undotree', keys = { { '<Leader>u', '<CMD>UndotreeToggle<CR>' } } },
    {
        'akinsho/toggleterm.nvim',
        keys = '<C-t>',
        opts = {
            size = 20,
            open_mapping = [[<C-t>]],
        },
    },
    {
        'Wansmer/treesj',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require('treesj').setup({
                use_default_keymaps = false,
            })

            vim.api.nvim_create_autocmd({ 'FileType' }, {
                pattern = '*',
                callback = function()
                    if require('treesj.langs').presets[vim.bo.filetype] then
                        vim.keymap.set('n', 'gS', '<Cmd>TSJSplit<CR>', { buffer = true })
                        vim.keymap.set('n', 'gJ', '<Cmd>TSJJoin<CR>', { buffer = true })
                    end
                end,
            })
        end,
    },
    { 'echasnovski/mini.ai', opts = {} },
    { 'yorickpeterse/nvim-pqf', opts = {} },
    {
        'simeji/winresizer',
        init = function()
            vim.g.winresizer_enable = 1
            vim.g.winresizer_gui_enable = 0
            vim.g.winresizer_finish_with_escape = 1
            vim.g.winresizer_vert_resize = 10
            vim.g.winresizer_horiz_resize = 3
            vim.g.winresizer_start_key = '<Leader>w'
        end,
    },
    {
        'stevearc/oil.nvim',
        opts = {
            -- Make split mappings consistent with Telescope.
            keymaps = {
                ['<C-s>'] = false,
                ['<C-h>'] = false,
                ['<C-v>'] = 'actions.select_vsplit',
                ['<C-x>'] = 'actions.select_split',
            },
        },
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {},
        keys = {
            { '<Leader>h', function() require('harpoon'):list():append() end },
            { '<Leader>H', function() require('harpoon'):list():prepend() end },
            {
                '<C-e>',
                function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end,
            },
            { '<Leader>1', function() require('harpoon'):list():select(1) end },
            { '<Leader>2', function() require('harpoon'):list():select(2) end },
            { '<Leader>3', function() require('harpoon'):list():select(3) end },
            { '<Leader>4', function() require('harpoon'):list():select(4) end },
            { '<Leader>5', function() require('harpoon'):list():select(5) end },

            -- Previous/next buffer using harpoon.
            { '[b', function() require('harpoon'):list():prev() end },
            { ']b', function() require('harpoon'):list():next() end },
        },
    },
}
