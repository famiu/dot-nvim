require('gitsigns').setup {
    signs = {
        add          = {hl = 'GitGutterAdd'   , text = '│', numhl='GitGutterAddNr'   , linehl='GitGutterAddLn'},
        change       = {hl = 'GitGutterChange', text = '│', numhl='GitGutterChangeNr', linehl='GitGutterChangeLn'},
        delete       = {hl = 'GitGutterDelete', text = '_', numhl='GitGutterDeleteNr', linehl='GitGutterDeleteLn'},
        topdelete    = {hl = 'GitGutterDelete', text = '‾', numhl='GitGutterDeleteNr', linehl='GitGutterDeleteLn'},
        changedelete = {hl = 'GitGutterChange', text = '~', numhl='GitGutterChangeNr', linehl='GitGutterChangeLn'},
    },
    numhl = false,
    linehl = false,
    keymaps = {
        -- Default keymap options
        noremap = true,

        ['n ]h'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
        ['n [h'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

        ['n <leader>ghn'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
        ['n <leader>ghp'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

        ['n <leader>ghs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
        ['n <leader>ghu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
        ['n <leader>ghr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
        ['n <leader>ghv'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
        ['n <leader>ghb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',

        -- Text objects
        ['o ih'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>',
        ['x ih'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>'
    },
    watch_index = {
        interval = 1000
    },
    current_line_blame = false,
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    use_decoration_api = true,
    use_internal_diff = true,  -- If luajit is present
}

vim.api.nvim_exec([[
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1
]], false)

local keys = {
    g = {
        h = {
            name = '+hunk',
            n = 'Next hunk',
            p = 'Previous hunk',
            s = 'Stage hunk',
            u = 'Undo hunk',
            v = 'Preview hunk',
            r = 'Reset hunk',
            b = 'Blame line'
        }
    }
}

require('whichkey_setup').register_keymap('leader', keys)
