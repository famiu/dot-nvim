-- Barbar
local bind = vim.api.nvim_set_keymap
local bufferline = vim.g.bufferline
local v = vim.v

bufferline = {}

bufferline.animation = true
bufferline.auto_hide = true
bufferline.closable = true
bufferline.clickable = true

-- Enable/disable icons
-- If set to 'numbers', will show buffer index in the tabline
-- If set to 'both', will show buffer index and icons in the tabline
bufferline.icons = true

-- Sets the icon's highlight group.
-- If false, will use nvim-web-devicons colors
bufferline.icon_custom_colors = false

-- Configure icons on the bufferline.
bufferline.icon_separator_active = '▎'
bufferline.icon_separator_inactive = '▎'
bufferline.icon_close_tab = ''
bufferline.icon_close_tab_modified = '●'

-- Sets the maximum padding width with which to surround each tab
bufferline.maximum_padding = 4

-- If set, the letters for each buffer in buffer-pick mode will be
-- assigned based on their name. Otherwise or in case all letters are
-- already assigned, the behavior is to assign letters in order of
-- usability (see order below)
bufferline.semantic_letters = true

-- New buffer letters are assigned in this order. This order is
-- optimal for the qwerty keyboard layout but might need adjustement
-- for other layouts.
bufferline.letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP'

-- Sets the name of unnamed buffers. By default format is "[Buffer X]"
-- where X is the buffer number. But only a static string is accepted here.
bufferline.no_name_title = nil

-- Move to previous/next
bind('n', '<Leader>bp', ':BufferPrevious<CR>', { noremap = true, silent = true })
bind('n', '<Leader>bn', ':BufferNext<CR>', { noremap = true, silent = true })
-- Re-order to previous/next
bind('n', '<Leader>bmp', ':BufferMovePrevious<CR>', { noremap = true, silent = true })
bind('n', '<Leader>bmn', ':BufferMoveNext<CR>', { noremap = true, silent = true })
-- Goto buffer in position...
bind('n', '<Leader>b1', ':BufferGoto 1<CR>', { noremap = true, silent = true })
bind('n', '<Leader>b2', ':BufferGoto 2<CR>', { noremap = true, silent = true })
bind('n', '<Leader>b3', ':BufferGoto 3<CR>', { noremap = true, silent = true })
bind('n', '<Leader>b4', ':BufferGoto 4<CR>', { noremap = true, silent = true })
bind('n', '<Leader>b5', ':BufferGoto 5<CR>', { noremap = true, silent = true })
bind('n', '<Leader>b6', ':BufferGoto 6<CR>', { noremap = true, silent = true })
bind('n', '<Leader>b7', ':BufferGoto 7<CR>', { noremap = true, silent = true })
bind('n', '<Leader>b8', ':BufferGoto 8<CR>', { noremap = true, silent = true })
bind('n', '<Leader>b9', ':BufferLast<CR>', { noremap = true, silent = true })
-- Close buffer
bind('n', '<Leader>bd', ':BufferClose<CR>', { noremap = true, silent = true })
-- Kill buffer
bind('n', '<Leader>bk', ':BufferDelete<CR>', { noremap = true, silent = true })
-- Magic buffer-picking mode
bind('n', '<Leader>bc', ':BufferPick<CR>', { noremap = true, silent = true })
-- Sort automatically by...
bind('n', '<Space>bod', ':BufferOrderByDirectory<CR>', { noremap = true, silent = true })
bind('n', '<Space>bol', ':BufferOrderByLanguage<CR>', { noremap = true, silent = true })

local keys = {
    b = {
        name = '+buffer',
        ['1'] = 'Goto 1',
        ['2'] = 'Goto 2',
        ['3'] = 'Goto 3',
        ['4'] = 'Goto 4',
        ['5'] = 'Goto 5',
        ['6'] = 'Goto 6',
        ['7'] = 'Goto 7',
        ['8'] = 'Goto 8',
        ['9'] = 'Goto Last',
        c = 'Choose',
        n = 'Next',
        p = 'Previous',
        d = 'Close',
        k = 'Kill',
        m = {
            name = '+move',
            n = 'Next',
            p = 'Previous'
        },
        o = {
            name = '+order',
            d = 'By Directory',
            l = 'By Language'
        }
    },
}

require('whichkey_setup').register_keymap('leader', keys)
