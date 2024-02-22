local keymap = vim.keymap

return {
    {
        'echasnovski/mini.hues',
        config = function()
            vim.cmd.colorscheme('mycolors')
        end
    },
    {
        'famiu/bufdelete.nvim',
        name = 'bufdelete',
        dev = true,
        init = function()
            vim.g.bufdelete_buf_filter = require('utilities.tabline').get_buffer_list
            keymap.set('n', '<Leader>x', function()
                local target_buffer

                -- Delete current buffer is no count is provided.
                -- If count is provided, then delete the buffer corresponding to the count in the
                -- buffer list in the tabline.
                if vim.v.count == 0 then
                    target_buffer = vim.api.nvim_get_current_buf()
                else
                    target_buffer = require('utilities.tabline').get_buffer_list()[vim.v.count]
                end

                require('bufdelete').bufdelete(target_buffer)
            end , { silent = true })
        end,
        cmd = { 'Bdelete', 'Bwipeout' }
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
            { 'ds',  '<Plug>Dsurround' },
            { 'cs',  '<Plug>Csurround' },
            { 'cS',  '<Plug>CSurround' },
            { 'ys',  '<Plug>Ysurround' },
            { 'yS',  '<Plug>YSurround' },
            { 'yss', '<Plug>Yssurround' },
            { 'ySs', '<Plug>YSsurround' },
            { 'ySS', '<Plug>YSsurround' },
            { 'gs',  '<Plug>VSurround',  mode = 'x' },
            { 'gS',  '<Plug>VgSurround', mode = 'x' },
        }
    },
    'tpope/vim-sleuth',
    'tpope/vim-eunuch',
    { 'mbbill/undotree', keys = {{ '<Leader>u', '<CMD>UndotreeToggle<CR>' }} },
    {
        'akinsho/toggleterm.nvim',
        keys = '<C-t>',
        opts = {
            size = 20,
            open_mapping = [[<C-t>]],
        },
    },
    {
        'echasnovski/mini.splitjoin',
        config = function ()
            local splitjoin = require('mini.splitjoin')
            local gen_hook = splitjoin.gen_hook
            local curly = { brackets = { '%b{}' } }
            local add_comma_curly = gen_hook.add_trailing_separator(curly)
            local del_comma_curly = gen_hook.del_trailing_separator(curly)
            local pad_curly = gen_hook.pad_brackets(curly)

            splitjoin.setup()

            local group = vim.api.nvim_create_augroup('MiniSplitjoinConfig', {})
            vim.api.nvim_create_autocmd('FileType', {
                group = group,
                pattern = 'lua',
                callback = function(opts)
                    vim.b[opts.buf].minisplitjoin_config = {
                        split = { hooks_post = { add_comma_curly } },
                        join  = { hooks_post = { del_comma_curly, pad_curly } },
                    }
                end
            })
        end
    },
    { 'echasnovski/mini.ai', opts = {}, },
    { 'yorickpeterse/nvim-pqf', opts = {} },
    {
        'simeji/winresizer',
        init = function()
            vim.g.winresizer_enable = 1
            vim.g.winresizer_gui_enable = 0
            vim.g.winresizer_finish_with_escape = 1
            vim.g.winresizer_vert_resize = 10
            vim.g.winresizer_horiz_resize = 3
            vim.g.winresizer_start_key = '<Leader>wr'
        end
    },
    {
        'jackMort/ChatGPT.nvim',
        event = 'VeryLazy',
        opts = {},
        dependencies = {
            'MunifTanjim/nui.nvim',
            'nvim-lua/plenary.nvim',
            'folke/trouble.nvim',
            'nvim-telescope/telescope.nvim',
        },
        cmd = {
            'ChatGPT',
            'ChatGPTActAs',
            'ChatGPTEditWithInstructions',
            'ChatGPTRun',
        },
    },
}
