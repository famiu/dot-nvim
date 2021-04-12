local colors = require('statusline.defaults').colors
local separators = require('statusline.defaults').separators
local gen = require('statusline.generator')

local lsp = require('statusline.providers.lsp')
local vi_mode_utils = require('statusline.providers.vi_mode')

gen.properties.force_inactive.filetypes = {
    'NvimTree',
    'dbui',
    'packer',
    'startify',
    'fugitive',
    'fugitiveblame'
}

gen.properties.force_inactive.buftypes = {
    'terminal'
}

gen.components.left.active[1] = {
    provider = '▊ ',
    hl = {
        fg = colors.skyblue
    }
}

gen.components.left.active[2] = {
    provider = 'vi_mode',
    hl = function()
        local val = {}

        val.name = vi_mode_utils.get_mode_highlight_name()
        val.fg = vi_mode_utils.get_mode_color()
        val.style = 'bold'

        return val
    end,
    right_sep = ' '
}

gen.components.left.active[3] = {
    provider = 'file_info',
    hl = {
        fg = colors.white,
        bg = colors.oceanblue,
        style = 'bold'
    },
    left_sep = ' ' .. separators.slant_left_2,
    right_sep = separators.slant_right_2 .. ' '
}

gen.components.left.active[4] = {
    provider = 'file_size',
    enabled = function() return vim.fn.getfsize(vim.fn.expand('%:t')) > 0 end,
    right_sep = {
        str = ' ' .. separators.slant_left_2_thin .. ' ',
        hl = {
            fg = colors.fg,
            bg = colors.bg
        }
    }
}

gen.components.left.active[5] = {
    provider = 'position',
    right_sep = {
        str = ' ' .. separators.slant_right_2_thin,
        hl = {
            fg = colors.fg,
            bg = colors.bg
        }
    }
}

gen.components.left.active[6] = {
    provider = 'diagnostic_errors',
    enabled = function() return lsp.diagnostics_exist('Error') end,
    hl = { fg = colors.red }
}

gen.components.left.active[7] = {
    provider = 'diagnostic_warnings',
    enabled = function() return lsp.diagnostics_exist('Warning') end,
    hl = { fg = colors.yellow }
}

gen.components.left.active[8] = {
    provider = 'diagnostic_hints',
    enabled = function() return lsp.diagnostics_exist('Hint') end,
    hl = { fg = colors.cyan }
}

gen.components.left.active[9] = {
    provider = 'diagnostic_info',
    enabled = function() return lsp.diagnostics_exist('Information') end,
    hl = { fg = colors.skyblue }
}

gen.components.right.active[1] = {
    provider = 'git_branch',
    hl = {
        fg = colors.white,
        bg = colors.black,
        style = 'bold'
    },
    right_sep = {
        str = function()
            if vim.b.gitsigns_status_dict then return ' ' else return '' end
        end,
        hl = {
            fg = 'NONE',
            bg = colors.black
        }
    }
}

gen.components.right.active[2] = {
    provider = 'git_diff_added',
    hl = {
        fg = colors.green,
        bg = colors.black
    }
}

gen.components.right.active[3] = {
    provider = 'git_diff_changed',
    hl = {
        fg = colors.orange,
        bg = colors.black
    }
}


gen.components.right.active[4] = {
    provider = 'git_diff_removed',
    hl = {
        fg = colors.red,
        bg = colors.black
    },
    right_sep = {
        str = function()
            if vim.b.gitsigns_status_dict then return ' ' else return '' end
        end,
        hl = {
            fg = 'NONE',
            bg = colors.black
        }
    }
}


gen.components.right.active[5] = {
    provider = 'line_percentage',
    hl = {
        style = 'bold'
    },
    left_sep = '  ',
    right_sep = ' '
}

gen.components.right.active[6] = {
    provider = 'scroll_bar',
    hl = {
        fg = colors.skyblue,
        style = 'bold'
    }
}

gen.components.left.inactive[1] = {
    provider = 'file_type',
    hl = {
        fg = colors.white,
        bg = colors.oceanblue,
        style = 'bold'
    },
    left_sep = {
        str = ' ',
        hl = {
            fg = 'NONE',
            bg = colors.oceanblue
        }
    },
    right_sep = {
        {
            str = ' ',
            hl = {
                fg = 'NONE',
                bg = colors.oceanblue
            }
        },
        separators.slant_right
    }
}
