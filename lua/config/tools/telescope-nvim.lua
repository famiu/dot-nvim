-- Telescope setup
require('telescope').setup{
    defaults = {
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case'
        },

        prompt_position = "bottom",
        prompt_prefix = "> ",

        selection_caret = "> ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",

        layout_strategy = "horizontal",

        layout_defaults = {
            horizontal = {
                mirror = false,
            },
            vertical = {
                mirror = false,
            },
        },

        file_sorter =  require'telescope.sorters'.get_fuzzy_file,
        file_ignore_patterns = {},

        generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
        shorten_path = true,
        winblend = 0,
        width = 0.75,
        preview_cutoff = 120,

        results_height = 1,
        results_width = 0.8,

        border = {},
        borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },

        color_devicons = true,
        use_less = true,
        set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,

        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
    }
}

-- Telescope modules
require('telescope').load_extension('dap')

local bind_picker = require('config.tools.telescope-nvim-utils').bind_picker

-- Alt-Shift-P command palette
bind_picker('<S-A-p>', 'commands')

-- Normal
bind_picker('<Leader>ff', 'find_files')
bind_picker('<Leader>fg', 'live_grep')
bind_picker('<Leader>fb', 'buffers')
bind_picker('<Leader>fh', 'help_tags')
bind_picker('<Leader>ft', 'treesitter')

local keys = {
    f = {
        name = '+telescope',
        b = 'Buffers',
        f = 'Find files',
        g = 'Live grep',
        h = 'Help tags',
        t = 'Treesitter'
    }
}

-- DAP
bind_picker('<Leader>dc', 'commands', 'dap')
bind_picker('<Leader>ds', 'configurations', 'dap')
bind_picker('<Leader>dl', 'list_breakpoints', 'dap')
bind_picker('<Leader>dv', 'variables', 'dap')
bind_picker('<Leader>df', 'frames', 'dap')

keys.d = {
    name = '+dap',
    c = 'Commands',
    s = 'Configurations',
    l = 'List breakpoints',
    v = 'Variables',
    f = 'Frames',
}

require('whichkey_setup').register_keymap('leader', keys)
