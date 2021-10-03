local api = vim.api

local lsp = require('feline.providers.lsp')
local vi_mode = require('feline.providers.vi_mode')
local git = require('feline.providers.git')

local components = { active = {} }

-- Active statusline
components.active[1] = {
    {
        provider = function()
            return ' ' .. vi_mode.get_vim_mode()
        end,
        hl = function()
            return {
                fg = vi_mode.get_mode_color(),
                bg = 'gray',
                style = 'bold'
            }
        end,
        left_sep = {
            str = 'left_rounded',
            hl = {
                fg = 'gray',
            }
        },
        right_sep = {
            str = 'right_rounded',
            hl = {
                fg = 'gray',
            }
        }
    },
    {
        provider = 'file_info',
        hl = {
            fg = 'cyan',
            bg = 'gray',
            style = 'bold'
        },
        left_sep = {
            ' ',
            {
                str = 'left_rounded',
                hl = {
                    fg = 'gray',
                }
            },
            {
                str = ' ',
                hl = {
                    bg = 'gray'
                }
            }
        },
        right_sep = {
            {
                str = 'right_rounded',
                hl = {
                    fg = 'gray',
                }
            },
            ' ',
        }
    },
    {
        provider = function()
            return string.format('%d:%d', unpack(api.nvim_win_get_cursor(0)))
        end,
        hl = {
            fg = 'orange',
            bg = 'gray'
        },
        left_sep = {
            {
                str = 'left_rounded',
                hl = {
                    fg = 'gray',
                }
            },
            {
                str = ' ',
                hl = {
                    bg = 'gray'
                }
            }
        },
        right_sep = {
            {
                str = ' ',
                hl = {
                    bg = 'gray'
                }
            },
            {
                str = 'vertical_bar_thin',
                hl = {
                    fg = 'lightgray',
                    bg = 'gray'
                }
            },
            {
                str = ' ',
                hl = {
                    bg = 'gray'
                }
            }
        }
    },
    {
        provider = 'line_percentage',
        hl = {
            fg = 'orange',
            bg = 'gray'
        },
        right_sep = {
            {
                str = ' ',
                hl = {
                    bg = 'gray'
                }
            },
            {
                str = 'right_rounded',
                hl = {
                    fg = 'gray',
                }
            },
            ' '
        }
    }
}

components.active[2] = {
    {
        provider = ' LSP',
        enabled = function()
            return lsp.diagnostics_exist('Error') or
                lsp.diagnostics_exist('Warning') or
                lsp.diagnostics_exist('Hint') or
                lsp.diagnostics_exist('Information')
        end,
        hl = {
            fg = 'cyan',
            bg = 'gray'
        },
        left_sep = {
            {
                str = 'left_rounded',
                hl = {
                    fg = 'gray',
                }
            },
            {
                str = ' ',
                hl = {
                    bg = 'gray'
                }
            }
        },
    },
    {
        provider = 'diagnostic_errors',
        hl = {
            fg = 'red',
            bg = 'gray'
        }
    },
    {
        provider = 'diagnostic_warnings',
        hl = {
            fg = 'yellow',
            bg = 'gray'
        }
    },
    {
        provider = 'diagnostic_hints',
        hl = {
            fg = 'cyan',
            bg = 'gray'
        }
    },
    {
        provider = 'diagnostic_info',
        hl = {
            fg = 'oceanblue',
            bg = 'gray'
        }
    },
    {
        enabled = function()
            return lsp.diagnostics_exist('Error') or
                lsp.diagnostics_exist('Warning') or
                lsp.diagnostics_exist('Hint') or
                lsp.diagnostics_exist('Information')
        end,
        right_sep = {
            {
                str = ' ',
                hl = {
                    bg = 'gray'
                },
                always_visible = true
            },
            {
                str = 'right_rounded',
                hl = {
                    fg = 'gray',
                },
                always_visible = true
            },
            { str = ' ', always_visible = true }
        }
    },
    {
        enabled = git.git_info_exists,
        left_sep = {
            {
                str = 'left_rounded',
                hl = {
                    fg = 'gray',
                },
                always_visible = true
            },
            {
                str = ' ',
                hl = {
                    bg = 'gray'
                },
                always_visible = true
            }
        },
    },
    {
        provider = 'git_branch',
        hl = {
            bg = 'gray',
            style = 'bold'
        },
    },
    {
        provider = 'git_diff_added',
        hl = {
            fg = 'green',
            bg = 'gray'
        }
    },
    {
        provider = 'git_diff_changed',
        hl = {
            fg = 'orange',
            bg = 'gray'
        }
    },
    {
        provider = 'git_diff_removed',
        hl = {
            fg = 'red',
            bg = 'gray'
        },
    },
    {
        enabled = git.git_info_exists,
        right_sep = {
            {
                str = ' ',
                hl = {
                    bg = 'gray'
                },
                always_visible = true
            },
            {
                str = 'right_rounded',
                hl = {
                    fg = 'gray',
                },
                always_visible = true
            },
        }
    }
}

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
    colors = {
        fg = '#FFFFFF',
        bg = 'NONE',
        lightgray = '#323232',
        gray = '#131619',
        blue = '#506275',
        green = '#5E9274',
        cyan = '#51AAAB',
        purple = '#78558C',
    },
    vi_mode_colors = {
        ['NORMAL'] = 'green',
        ['OP'] = 'green',
        ['INSERT'] = 'red',
        ['VISUAL'] = 'oceanblue',
        ['LINES'] = 'oceanblue',
        ['BLOCK'] = 'oceanblue',
        ['REPLACE'] = 'purple',
        ['V-REPLACE'] = 'purple',
        ['ENTER'] = 'cyan',
        ['MORE'] = 'cyan',
        ['SELECT'] = 'orange',
        ['COMMAND'] = 'green',
        ['SHELL'] = 'green',
        ['TERM'] = 'green',
        ['NONE'] = 'yellow'
    }
}
