local g = vim.g

g.indent_blankline_enabled = true

g.indent_blankline_char = '│'
g.indent_blankline_space_char_blankline = ' '

g.indent_blankline_indent_level = 10
g.indent_blankline_show_first_indent_level = true
g.indent_blankline_show_trailing_blankline_indent = false

g.indent_blankline_use_treesitter = true
g.indent_blankline_show_current_context = true
g.indent_blankline_context_patterns = {
    'class', 'function', 'method', '^if', '^while',
    '^for', '^object', '^table', 'block', 'arguments'
}

g.indent_blankline_filetype_exclude = {'help', 'startify', 'NvimTree', 'undotree', 'packer'}
g.indent_blankline_buftype_exclude = {'terminal', 'nofile'}

vim.api.nvim_set_keymap(
    'n', '<Leader>ti',
    '<cmd>IndentBlanklineToggle<CR>',
    { noremap = true, silent = true }
)

require('which-key').register({
    t = {
        name = '+ui-toggle',
        i = 'Indent guides',
    }
}, { prefix = "<leader>" })
