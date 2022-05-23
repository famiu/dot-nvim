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
        provider = {
            name = 'file_info',
            opts = {
                type = 'unique',
                colored_icon = false
            }
        },
        right_sep = '  '
    },
    {
        provider = 'position_custom',
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

components.inactive[1] = {
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
        },
    },
}

components.inactive[2] = {
    {
        provider = 'position_custom',
        right_sep = ' '
    }
}

-- Setup feline.nvim
require('feline').setup {
    components = components,
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
    force_inactive = {
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
    },
    custom_providers = {
        position_custom = function()
            local line, col = unpack(api.nvim_win_get_cursor(0))
            col = vim.str_utfindex(api.nvim_get_current_line(), col) + 1

            return string.format('Ln %d, Col %d', line, col)
        end
    },
}

local winbar_components = {
    active = {
        {
            {
                provider = 'file_info',
                hl = {
                    fg = 'skyblue',
                    bg = 'NONE',
                    style = 'bold',
                },
            },
        },
    },
    inactive = {
        {
            {
                provider = 'file_info',
                hl = {
                    fg = 'white',
                    bg = 'NONE',
                    style = 'bold',
                },
            },
        },
    },
}

-- Setup feline.nvim winbar
require('feline').winbar.setup {
    components = winbar_components
}
