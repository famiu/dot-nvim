local M = {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-ui-select.nvim'
    },
}

function M.config()
    require('telescope').setup {
        pickers = {
            buffers = {
                theme = 'ivy'
            }
        },
        extensions = {
            ['ui-select'] = {
                require('telescope.themes').get_dropdown {
                }
            }
        }
    }

    require('telescope').load_extension('ui-select')

    local ts_builtin = require('telescope.builtin')
    local keymap = vim.keymap

    keymap.set('n', '<Leader>ff', ts_builtin.find_files, {})
    keymap.set('n', '<Leader>fg', ts_builtin.live_grep, {})
    keymap.set('n', '<Leader>fb', ts_builtin.buffers, {})
    keymap.set('n', '<Leader>fh', ts_builtin.help_tags, {})
    keymap.set('n', '<Leader>ft', ts_builtin.treesitter, {})
    keymap.set('n', '<Leader>fd', ts_builtin.diagnostics, {})
    keymap.set('n', '<Leader>fo', ts_builtin.oldfiles, {})
    keymap.set('n', '<Leader>qf', ts_builtin.quickfix, {})
end

return M
