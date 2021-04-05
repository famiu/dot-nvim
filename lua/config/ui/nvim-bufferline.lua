require'bufferline'.setup {
    options = {
        view = "multiwindow",
        numbers = "ordinal",
        number_style = "superscript", -- buffer_id at index 1, ordinal at index 2
        mappings = false,
        buffer_close_icon= '',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        max_name_length = 18,
        max_prefix_length = 15, -- prefix used when a buffer is deduplicated
        tab_size = 18,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
        end,
        -- NOTE: this will be called a lot so don't do any heavy processing here
        custom_filter = function(buf_number)
            -- Filter out terminal buffers
            if vim.bo[buf_number].buftype ~= "terminal" then
                return true
            end
        end,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        -- whether or not custom sorted buffers should persist
        persist_buffer_sort = true,
        -- can also be a table containing 2 custom separators
        -- [focused and unfocused]. eg: { '|', '|' }
        -- separator_style = "slant" | "thick" | "thin" | { 'any', 'any' },
        separator_style = "slant",
        enforce_regular_tabs = true,
        always_show_bufferline = true,
        sort_by = 'directory'
    }
}

-- Keybinds
local bind = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- These commands will navigate through buffers in order regardless of which mode you are using
-- e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
bind('n', 'b[', ':BufferLineCycleNext<CR>', opts)
bind('n', 'b]', ':BufferLineCyclePrev<CR>', opts)

bind('n', '<Leader>bn', ':BufferLineCycleNext<CR>', opts)
bind('n', '<Leader>bp', ':BufferLineCyclePrev<CR>', opts)

-- These commands will move the current buffer backwards or forwards in the bufferline
bind('n', '<Leader>bmn', ':BufferLineMoveNext<CR>', opts)
bind('n', '<Leader>bmp', ':BufferLineMovePrev<CR>', opts)

-- These commands will sort buffers by directory, language, or a custom criteria
bind('n', '<Leader>boe', ':BufferLineSortByExtension<CR>', opts)
bind('n', '<Leader>bod', ':BufferLineSortByDirectory<CR>', opts)

-- Goto buffer
bind('n', '<Leader>b1', ':lua require("bufferline").go_to_buffer(1)<CR>', opts)
bind('n', '<Leader>b2', ':lua require("bufferline").go_to_buffer(2)<CR>', opts)
bind('n', '<Leader>b3', ':lua require("bufferline").go_to_buffer(3)<CR>', opts)
bind('n', '<Leader>b4', ':lua require("bufferline").go_to_buffer(4)<CR>', opts)
bind('n', '<Leader>b5', ':lua require("bufferline").go_to_buffer(5)<CR>', opts)
bind('n', '<Leader>b6', ':lua require("bufferline").go_to_buffer(6)<CR>', opts)
bind('n', '<Leader>b7', ':lua require("bufferline").go_to_buffer(7)<CR>', opts)
bind('n', '<Leader>b8', ':lua require("bufferline").go_to_buffer(8)<CR>', opts)
bind('n', '<Leader>b9', ':lua require("bufferline").go_to_buffer(9)<CR>', opts)

-- Pick buffer
bind('n', '<Leader>bc', ':BufferLinePick<CR>', opts)

-- Close / kill buffer
bind('n', '<Leader>bd', ':bdelete<CR>', opts)
bind('n', '<Leader>bk', ':bwipeout<CR>', opts)

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
        sort = {
            name = '+sort',
            d = 'By Directory',
            e = 'By Extension'
        }
    },
}

require('whichkey_setup').register_keymap('leader', keys)
