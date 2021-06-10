-- Nvim Tree
local g = vim.g
local bind = vim.api.nvim_set_keymap

g.nvim_tree_side = 'left'
g.nvim_tree_width = 40
g.nvim_tree_ignore = {'.git', 'node_modules', '.cache'}
g.nvim_tree_gitignore = 1
g.nvim_tree_auto_open = 1
g.nvim_tree_auto_close = 0
g.nvim_tree_auto_ignore_ft = {'startify', 'dashboard'}
g.nvim_tree_quit_on_open = 0
g.nvim_tree_follow = 1
g.nvim_tree_indent_markers = 1
g.nvim_tree_hide_dotfiles = 1
g.nvim_tree_git_hl = 1
g.nvim_tree_highlight_opened_files = 0
g.nvim_tree_root_folder_modifier = ':~'
g.nvim_tree_tab_open = 1
g.nvim_tree_width_allow_resize = 0
g.nvim_tree_disable_netrw = 1
g.nvim_tree_hijack_netrw = 1
g.nvim_tree_add_trailing = 0
g.nvim_tree_group_empty = 1
g.nvim_tree_lsp_diagnostics = 1
g.nvim_tree_disable_window_picker = 0
g.nvim_tree_hijack_cursor = 1
g.nvim_tree_icon_padding = ' '
g.nvim_tree_update_cwd = 0
g.nvim_tree_window_picker_exclude = {
    filetype = {'packer', 'qf', 'startify'},
    buftype = {'terminal', 'toggleterm'}
}
g.nvim_tree_special_files = {
    'README.md',
    'LICENSE',
    'LICENSE.md',
    'Makefile',
    'MAKEFILE',
    'CMakeLists.txt',
    'Cargo.toml'
}
g.nvim_tree_show_icons = {
    git = 1,
    folders = 1,
    files = 1,
    folder_arrows = 0
}
g.nvim_tree_icons = {
    default = '',
    symlink = '',
    git = {
        unstaged = "✗",
        staged = "✓",
        unmerged = "",
        renamed = "➜",
        untracked = "★",
        deleted = "",
        ignored = "◌"
    },
    folder = {
        arrow_open = "",
        arrow_closed = "",
        default = "",
        open = "",
        empty = "",
        empty_open = "",
        symlink = "",
        symlink_open = "",
    },
    lsp = {
        hint = "",
        info = "",
        warning = "",
        error = "",
    }
}

bind('n', '<Leader>tn', ':NvimTreeToggle<CR>', { noremap = true })

require('which-key').register({
    t = {
        name = '+ui-toggle',
        n = 'NvimTree',
    }
}, { prefix = "<leader>" })
