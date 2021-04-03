local bind = vim.api.nvim_buf_set_keymap

function GodotSettings()
    bind(0, 'n', '<LocalLeader>l', ':GodotRunLast<CR>', { noremap = true })
    bind(0, 'n', '<LocalLeader>r', ':GodotRun<CR>', { noremap = true })
    bind(0, 'n', '<LocalLeader>c', ':GodotRunCurrent<CR>', { noremap = true })
    bind(0, 'n', '<LocalLeader>f', ':GodotRunFZF<CR>', { noremap = true })

    local keys = {
        l = 'Run last',
        r = 'Run',
        c = 'Run Current',
        f = 'Run FZF'
    }

    require('whichkey_setup').register_keymap('localleader', keys)
end

require('utils').create_augroup({
	{'FileType', 'gdscript', 'lua GodotSettings()'},
}, 'godot')
