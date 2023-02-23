local M = {
    'nvim-telescope/telescope.nvim',
    lazy = true,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-ui-select.nvim'
    },
}

function M.init()
    local keymap = vim.keymap

    keymap.set('n', '<Leader>ff', function() require('telescope.builtin').find_files() end, {})
    keymap.set('n', '<Leader>fg', function() require('telescope.builtin').live_grep() end, {})
    keymap.set('n', '<Leader>fb', function() require('telescope.builtin').buffers() end, {})
    keymap.set('n', '<Leader>fh', function() require('telescope.builtin').help_tags() end, {})
    keymap.set('n', '<Leader>ft', function() require('telescope.builtin').treesitter() end, {})
    keymap.set('n', '<Leader>fd', function() require('telescope.builtin').diagnostics() end, {})
    keymap.set('n', '<Leader>fo', function() require('telescope.builtin').oldfiles() end, {})
    keymap.set('n', '<Leader>qf', function() require('telescope.builtin').quickfix() end, {})
end

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
end

return M
