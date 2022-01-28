local api = vim.api

local vi_mode = require('feline.providers.vi_mode')
local git = require('feline.providers.git')
local lsp = require('feline.providers.lsp')
local gps = require('nvim-gps')

gps.setup()

local components = { active = {}, inactive = {} }

-- Active statusline
components.active[1] = {
    {
        provider = 'git_branch',
        left_sep = ' ',
        right_sep = ' '
    },
    {
        enabled = function()
            return vim.bo.filetype ~= ''
        end,
        provider = {
            name = 'file_type',
            opts = {
                case = 'titlecase',
                filetype_icon = true,
                colored_icon = false
            }
        },
        left_sep = ' ',
        right_sep = '  '
    },
    {
        provider = 'vi_mode',
        icon = '',
        hl = function()
            return {
                fg = vi_mode.get_mode_color(),
                bg = 'gray',
                style = 'bold'
            }
        end,
        left_sep = {
            {
                str = 'left_filled',
                hl = { fg = 'gray' }
            },
            {
                str = ' ',
                hl = { bg = 'gray' }
            }
        },
        right_sep = {
            {
                str = ' ',
                hl = { bg = 'gray' }
            },
            {
                str = 'right_filled',
                hl = { fg = 'gray' }
            },
            '  '
        },
    },
    {
        enabled = function()
            return gps.is_available()
        end,
        provider = function()
            return gps.get_location()
        end,
        hl = {
            fg = 'white',
        },
    }
}

components.active[2] = {
    {
        provider = function()
            local line, col = unpack(api.nvim_win_get_cursor(0))
            col = vim.str_utfindex(api.nvim_get_current_line(), col) + 1

            return string.format('Ln %d, Col %d', line, col)
        end,
        right_sep = ' '
    },
    {
        provider = 'git_diff_added',
    },
    {
        provider = 'git_diff_changed',
    },
    {
        provider = 'git_diff_removed',
    },
    {
        enabled = function()
            return git.git_info_exists()
        end,
        right_sep = { str = ' ', always_visible = true }
    },
    {
        provider = 'diagnostic_errors',
    },
    {
        provider = 'diagnostic_warnings',
    },
    {
        provider = 'diagnostic_hints',
    },
    {
        provider = 'diagnostic_info',
    },
    {
        enabled = function()
            return lsp.diagnostics_exist()
        end,
        right_sep = { str = ' ', always_visible = true }
    }
}

local VertSplitFG = string.format('#%06x', api.nvim_get_hl_by_name('VertSplit', true).foreground)

-- Use thin line for horizontal splits
api.nvim_command(string.format(
    'highlight StatusLineNC gui=underline guifg=%s guibg=NONE',
    VertSplitFG
))

-- Setup feline.nvim
require('feline').setup {
    components = components,
    default_hl = {
        inactive = {
            fg = string.format('#%06x', api.nvim_get_hl_by_name('VertSplit', true).foreground),
            bg = 'NONE',
            style = 'underline'
        }
    },
    theme = {
        fg = '#FFFFFF',
        bg = '#007ACD',
        lightgray = '#323232',
        gray = '#131619',
        blue = '#506275',
        green = '#5E9274',
        cyan = '#51AAAB',
        purple = '#78558C',
        darkpurple = '#67217A',
    },
    disable = {
        filetypes = {
            '^NvimTree$',
            '^packer$',
            '^startify$',
            '^fugitive$',
            '^fugitiveblame$',
            '^qf$',
            '^help$',
        },
        buftypes = {
            '^terminal$',
            '^nofile$'
        },
    }
}
