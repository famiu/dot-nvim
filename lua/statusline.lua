local gl = require('galaxyline')
local colors = require('galaxyline.theme').default
local condition = require('galaxyline.condition')
local gls = gl.section

local separators = {
    vertical_bar = '┃',
    vertical_bar_thin = '│',
    left = '',
    right = '',
    left_filled = '',
    right_filled = '',
    slant_left = '',
    slant_left_thin = '',
    slant_right = '',
    slant_right_thin = '',
    slant_left_2 = '',
    slant_left_2_thin = '',
    slant_right_2 = '',
    slant_right_2_thin = '',
    left_rounded = '',
    left_rounded_thin = '',
    right_rounded = '',
    right_rounded_thin = '',
    circle = '●'
}

local colors_custom = {
    white = '#FFFFFF',
    black = '#1e1e1e',
    blue = '#0066cc',
}

gl.short_line_list = {
    'NvimTree',
    'vista',
    'dbui',
    'packer',
    'startify',
    'term',
    'fugitive',
    'fugitiveblame'
}

gls.left[1] = {
    RainbowRed = {
        provider = function() return '▊ ' end,
        highlight = {colors.blue,colors.bg}
    },
}

gls.left[2] = {
    ViMode = {
        provider = function()
        -- auto change color according the vim mode
            local mode_color = {
                n = colors.red,
                i = colors.green,
                v=colors.blue,
                [''] = colors.blue,
                V=colors.blue,
                c = colors.magenta,
                no = colors.red,
                s = colors.orange,
                S=colors.orange,
                [''] = colors.orange,
                ic = colors.yellow,
                R = colors.violet,
                Rv = colors.violet,
                cv = colors.red,
                ce=colors.red,
                r = colors.cyan,
                rm = colors.cyan,
                ['r?'] = colors.cyan,
                ['!']  = colors.red,
                t = colors.red
            }

            vim.api.nvim_command('hi GalaxyViMode guifg='..mode_color[vim.fn.mode()])
            return '  '
        end,

        separator = separators.slant_left_2,
        separator_highlight = {colors_custom.blue,colors.bg},
        highlight = {colors.red,colors.bg,'bold'}
    }
}

gls.left[3] ={
    FileIcon = {
        provider = 'FileIcon',
        condition = condition.buffer_not_empty,
        highlight = {colors.white,colors_custom.blue},
    }
}

gls.left[4] = {
    FileName = {
        provider = 'FileName',
        condition = condition.buffer_not_empty,
        separator = separators.slant_right_2 .. ' ',
        separator_highlight = {colors_custom.blue,colors.bg},
        highlight = {colors_custom.white,colors_custom.blue,'bold'}
    }
}

gls.left[5] = {
    FileSize = {
        provider = 'FileSize',
        condition = condition.buffer_not_empty,
        separator = separators.slant_left_2_thin .. ' ',
        separator_highlight = {colors.fg, colors.bg},
        highlight = {colors.fg,colors.bg}
    }
}

gls.left[6] = {
    LineInfo = {
        provider = 'LineColumn',
        separator = ' ' .. separators.slant_right_2_thin,
        separator_highlight = {colors.fg, colors.bg},
        highlight = {colors.fg,colors.bg},
    },
}

gls.left[7] = {
    DiagnosticError = {
        provider = 'DiagnosticError',
        icon = '  ',
        highlight = {colors.red,colors.bg}
    }
}

gls.left[8] = {
    DiagnosticWarn = {
        provider = 'DiagnosticWarn',
        icon = '  ',
        highlight = {colors.yellow,colors.bg},
    }
}

gls.left[9] = {
    DiagnosticHint = {
        provider = 'DiagnosticHint',
        icon = '  ',
        highlight = {colors.cyan,colors.bg},
    }
}

gls.left[10] = {
    DiagnosticInfo = {
        provider = 'DiagnosticInfo',
        icon = '  ',
        highlight = {colors.blue,colors.bg},
    }
}

gls.right[1] = {
    GitIcon = {
        provider = function() return '  ' end,
        condition = condition.check_git_workspace,
        -- separator = separators.vertical_bar,
        -- separator_highlight = {colors_custom.black,colors.bg},
        highlight = {colors_custom.white,colors_custom.black,'bold'},
    }
}

gls.right[2] = {
    GitBranch = {
        provider = 'GitBranch',
        condition = condition.check_git_workspace,
        highlight = {colors_custom.white,colors_custom.black,'bold'},
    }
}

gls.right[3] = {
    DiffAdd = {
        provider = 'DiffAdd',
        condition = condition.hide_in_width,
        icon = '  ',
        highlight = {colors.green,colors_custom.black},
    }
}
gls.right[4] = {
    DiffModified = {
        provider = 'DiffModified',
        condition = condition.hide_in_width,
        icon = ' 柳',
        highlight = {colors.orange,colors_custom.black},
    }
}
gls.right[5] = {
    DiffRemove = {
        provider = 'DiffRemove',
        condition = condition.hide_in_width,
        icon = '  ',
        highlight = {colors.red,colors_custom.black},
    }
}

gls.right[6] = {
    PerCent = {
        provider = 'LinePercent',
        -- separator = separators.vertical_bar .. ' ',
        -- separator_highlight = {colors_custom.black,colors.bg},
        separator = ' ',
        separator_highlight = {'NONE',colors.bg},
        highlight = {colors.fg,colors.bg,'bold'},
    }
}

gls.right[7] = {
    ScrollBar = {
        provider = 'ScrollBar',
        highlight = {colors.blue,colors.bg,'bold'},
    }
}

gls.short_line_left[1] = {
    BufferType = {
        provider = 'FileTypeName',
        separator = separators.slant_right,
        separator_highlight = {colors_custom.blue,colors.bg},
        highlight = {colors_custom.white,colors_custom.blue,'bold'}
    }
}

gls.short_line_left[2] = {
    SFileName = {
        provider =  'SFileName',
        condition = condition.buffer_not_empty,
        highlight = {colors.fg,colors.bg,'bold'}
    }
}

gls.short_line_right[1] = {
    BufferIcon = {
        provider= 'BufferIcon',
        highlight = {colors.fg,colors.bg}
    }
}
