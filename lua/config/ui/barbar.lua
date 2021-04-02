-- Barbar
local bind = vim.api.nvim_set_keymap
local bufferline = vim.g.bufferline
local v = vim.v

bufferline = {}

bufferline.animation = v['true']
bufferline.auto_hide = v['true']
bufferline.closable = v['true']
bufferline.clickable = v['true']

-- Enable/disable icons
-- If set to 'numbers', will show buffer index in the tabline
-- If set to 'both', will show buffer index and icons in the tabline
bufferline.icons = v['true']

-- Sets the icon's highlight group.
-- If false, will use nvim-web-devicons colors
bufferline.icon_custom_colors = v['false']

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
bufferline.semantic_letters = v['true']

-- New buffer letters are assigned in this order. This order is
-- optimal for the qwerty keyboard layout but might need adjustement
-- for other layouts.
bufferline.letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP'

-- Sets the name of unnamed buffers. By default format is "[Buffer X]"
-- where X is the buffer number. But only a static string is accepted here.
bufferline.no_name_title = v['null']

-- Move to previous/next
bind('n', '<A-h>', ':BufferPrevious<CR>', { noremap = true, silent = true })
bind('n', '<A-l>', ':BufferNext<CR>', { noremap = true, silent = true })
-- Re-order to previous/next
bind('n', '<S-A-h>', ':BufferMovePrevious<CR>', { noremap = true, silent = true })
bind('n', '<S-A-l>', ':BufferMoveNext<CR>', { noremap = true, silent = true })
-- Goto buffer in position...
bind('n', '<A-1>', ':BufferGoto 1<CR>', { noremap = true, silent = true })
bind('n', '<A-2>', ':BufferGoto 2<CR>', { noremap = true, silent = true })
bind('n', '<A-3>', ':BufferGoto 3<CR>', { noremap = true, silent = true })
bind('n', '<A-4>', ':BufferGoto 4<CR>', { noremap = true, silent = true })
bind('n', '<A-5>', ':BufferGoto 5<CR>', { noremap = true, silent = true })
bind('n', '<A-6>', ':BufferGoto 6<CR>', { noremap = true, silent = true })
bind('n', '<A-7>', ':BufferGoto 7<CR>', { noremap = true, silent = true })
bind('n', '<A-8>', ':BufferGoto 8<CR>', { noremap = true, silent = true })
bind('n', '<A-9>', ':BufferLast<CR>', { noremap = true, silent = true })
-- Close buffer
bind('n', '<A-x>', ':BufferClose<CR>', { noremap = true, silent = true })
-- Magic buffer-picking mode
bind('n', '<C-s>', ':BufferPick<CR>', { noremap = true, silent = true })
-- Sort automatically by...
bind('n', '<Space>bd', ':BufferOrderByDirectory<CR>', { noremap = true, silent = true })
bind('n', '<Space>bl', ':BufferOrderByLanguage<CR>', { noremap = true, silent = true })
