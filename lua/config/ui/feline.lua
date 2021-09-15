local api = vim.api
local exec = api.nvim_exec

local lsp = require('feline.providers.lsp')
local vi_mode = require('feline.providers.vi_mode')
local git = require('feline.providers.git')

local components = { active = {}, inactive = {} }

-- Use a thin line with the same highlight as VertSplit for inactive statusline
-- In order to do so, first get the fg, bg and style options of VertSplit
local InactiveStatusHL = {
    fg = exec("highlight VertSplit", true):match("guifg=(#[0-9A-Fa-f]+)") or "#444444",
    bg = exec("highlight VertSplit", true):match("guibg=(#[0-9A-Fa-f]+)") or "#1E1E1E",
    style = exec("highlight VertSplit", true):match("gui=(#[0-9A-Fa-f]+)") or "",
}

-- Add underline to inactive statusline highlight style
-- in order to have a thin line instead of the statusline
if InactiveStatusHL.style == '' then
    InactiveStatusHL.style = 'underline'
else
    InactiveStatusHL.style = InactiveStatusHL.style .. ',underline'
end

-- Apply the highlight to the statusline
-- by having an empty provider with the highlight
components.inactive[1] = {
    {
        provider = '',
        hl = InactiveStatusHL
    }
}

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
        provider = function(_, winid)
            return string.format('%d:%d', unpack(api.nvim_win_get_cursor(winid)))
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
    },
}

components.active[2] = {
    {
        provider = ' LSP',

        enabled = function(_, winid)
            local bufnr = api.nvim_win_get_buf(winid)

            return lsp.diagnostics_exist('Error', bufnr) or
                lsp.diagnostics_exist('Warning', bufnr) or
                lsp.diagnostics_exist('Hint', bufnr) or
                lsp.diagnostics_exist('Information', bufnr)
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
        enabled = function() return lsp.diagnostics_exist('Error') end,
        hl = {
            fg = 'red',
            bg = 'gray'
        }
    },
    {
        provider = 'diagnostic_warnings',
        enabled = function() return lsp.diagnostics_exist('Warning') end,
        hl = {
            fg = 'yellow',
            bg = 'gray'
        }
    },
    {
        provider = 'diagnostic_hints',
        enabled = function() return lsp.diagnostics_exist('Hint') end,
        hl = {
            fg = 'cyan',
            bg = 'gray'
        }
    },
    {
        provider = 'diagnostic_info',
        enabled = function() return lsp.diagnostics_exist('Information') end,
        hl = {
            fg = 'oceanblue',
            bg = 'gray'
        }
    },
    {
        provider = '',

        enabled = function(_, winid)
            local bufnr = api.nvim_win_get_buf(winid)

            return lsp.diagnostics_exist('Error', bufnr) or
                lsp.diagnostics_exist('Warning', bufnr) or
                lsp.diagnostics_exist('Hint', bufnr) or
                lsp.diagnostics_exist('Information', bufnr)
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
        provider = '',
        enable = function(winid) return git.git_info_exists(winid) end,
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
        provider = '',
        enable = function(winid) return git.git_info_exists(winid) end,
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
