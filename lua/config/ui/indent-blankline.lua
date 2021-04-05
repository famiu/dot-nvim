local g = vim.g

g.indent_blankline_char_list = {'│', '¦', '┆', '┊'}
g.indent_blankline_space_char_blankline = ' '
g.indent_blankline_use_treesitter = true
g.indent_blankline_indent_level = 4
g.indent_blankline_show_first_indent_level = true
g.indent_blankline_show_trailing_blankline_indent = false
g.indent_blankline_enabled = true
g.indent_blankline_filetype_exclude = {'help', 'startify', 'NvimTree', 'undotree'}
g.indent_blankline_buftype_exclude = {'terminal', 'nofile'}
