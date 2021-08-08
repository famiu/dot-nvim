local bind = vim.api.nvim_set_keymap

bind('n', '<Space>gb', ':Git blame<CR>', {})
bind('n', '<Space>gs', ':Git<CR>', {})
bind('n', '<Space>gc', ':Git commit -v<CR>', {})
bind('n', '<Space>ga', ':Git add -p<CR>', {})
bind('n', '<Space>gm', ':Git commit --amend<CR>', {})
bind('n', '<Space>gp', ':Git push<CR>', {})
bind('n', '<Space>gd', ':Gdiff<CR>', {})
bind('n', '<Space>gw', ':Gwrite<CR>', {})

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
        w = 'Write'
    },
}

require('which-key').register(keys, { prefix = "<leader>" })
