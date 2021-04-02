require('telescope').setup{
    defaults = {
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case'
        },

        prompt_position = "bottom",
        prompt_prefix = "> ",

        selection_caret = "> ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",

        layout_strategy = "horizontal",

        layout_defaults = {
            horizontal = {
                mirror = false,
            },
            vertical = {
                mirror = false,
            },
        },

        file_sorter =  require'telescope.sorters'.get_fuzzy_file,
        file_ignore_patterns = {},

        generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
        shorten_path = true,
        winblend = 0,
        width = 0.75,
        preview_cutoff = 120,

        results_height = 1,
        results_width = 0.8,

        border = {},
        borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },

        color_devicons = true,
        use_less = true,
        set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,

        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
    }
}

local bind_picker = function(keys, picker_name, extension_name)
    extension_name = extension_name or nil

    if extension_name ~= nil then
        vim.api.nvim_set_keymap(
            'n', keys,
            "<cmd>lua require('telescope').extensions['" .. extension_name .. "']"
            .. "['" .. picker_name .. "']()<CR>",
            {}
        )
    else
        vim.api.nvim_set_keymap(
            'n', keys,
            "<cmd>lua require('telescope.builtin')['" .. picker_name .. "']()<CR>",
            {}
        )
    end
end

-- Alt-Shift-P command palette
bind_picker('<S-A-p>', 'commands')

-- Normal
bind_picker('<Leader>ff', 'find_files')
bind_picker('<Leader>fg', 'live_grep')
bind_picker('<Leader>fb', 'buffers')
bind_picker('<Leader>fh', 'help_tags')

-- LSP
bind_picker('<Leader>lds', 'lsp_document_symbols')
bind_picker('<Leader>ldd', 'lsp_document_diagnostics')
bind_picker('<Leader>lws', 'lsp_workspace_symbols')
bind_picker('<Leader>lwd', 'lsp_workspace_diagnostics')
bind_picker('<Leader>lc', 'lsp_code_actions')

-- Treesitter
bind_picker('<Leader>ts', 'treesitter')

