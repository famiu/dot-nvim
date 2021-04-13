local bind = vim.api.nvim_set_keymap

bind('n', '<Space>gb', ':Gblame<CR>', {})
bind('n', '<Space>gs', ':Git<CR>', {})
bind('n', '<Space>gc', ':Git commit -v<CR>', {})
bind('n', '<Space>ga', ':Git add -p<CR>', {})
bind('n', '<Space>gm', ':Git commit --amend<CR>', {})
bind('n', '<Space>gp', ':Git push<CR>', {})
bind('n', '<Space>gd', ':Gdiff<CR>', {})
bind('n', '<Space>gw', ':Gwrite<CR>', {})
bind('n', '<Space>gvo', ':GV<CR>', {})
bind('n', '<Space>gvc', ':GV!<CR>', {})
bind('n', '<Space>gvl', ':GV?<CR>', {})

local keys = {
    g = {
        name = '+git',
        a = 'Add',
        b = 'Blame',
        c = 'Commit',
        d = 'Diff',
        m = 'Amend',
        p = 'Push',
        s = 'Status',
        v = {
            name = '+commit-browser',
            o = 'Open commit browser',
            c = 'List commits that affected current file',
            l = 'Fill location list with revisions of current file'
        },
        w = 'Write'
    },
}

require('whichkey_setup').register_keymap('leader', keys)
