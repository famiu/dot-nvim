return {
    {
        'tpope/vim-fugitive',
        cmd = { 'Git', 'Gedit', 'Gdiffsplit', 'Gvdiffsplit', 'Ghdiffsplit' },
        keys = {
            { '<Leader>gb', '<CMD>Git blame<CR>', silent = true, desc = 'Git blame' },
            { '<Leader>gc', '<CMD>Git commit<CR>', silent = true, desc = 'Git commit' },
            { '<Leader>gs', '<CMD>silent! Git<CR>', silent = true, desc = 'Git status' },
            { '<Leader>gl', '<CMD>Git log --oneline<CR>', silent = true, desc = 'Git log' },
            { '<Leader>gh', '<CMD>Git log --oneline -- %<CR>', silent = true, desc = 'Git log for current file' },
        },
    },
    {
        'sindrets/diffview.nvim',
        opts = {
            enhanced_diff_hl = true,
            view = {
                diff_view = {
                    layout = 'diff2_horizontal',
                },
                file_history_view = {
                    layout = 'diff2_horizontal',
                },
                merge_tool = {
                    layout = 'diff3_mixed',
                },
            },
        },
        cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
        keys = {
            { '<Leader>gd', '<CMD>DiffviewOpen<CR>', desc = 'Diff worktree' },
            { '<Leader>gf', '<CMD>DiffviewFileHistory<CR>', desc = 'Diffview file history' },
            {
                '<Leader>gD',
                function()
                    local target = vim.fn.input('Target branch name: ')
                    local status = vim.system(
                        { '/usr/bin/env', 'git', 'merge-base', 'HEAD', target },
                        { text = true }
                    ):wait()

                    if status.code ~= 0 then
                        error(string.format(
                            "Error code %d while running git merge-base. STDERR: %s",
                            status.code, status.stderr
                        ))
                    end

                    vim.cmd.DiffviewOpen(status.stdout)
                end,
                desc = 'Diff from common ancestor of target branch and current branch'
            },
            {
                '<Leader>g<C-d>',
                function()
                    vim.cmd.DiffviewOpen(vim.fn.input('Diff rev: '))
                end,
                desc = 'Diff rev'
            },
            { '<Leader>gt', '<CMD>DiffviewToggleFiles<CR>', desc = 'Toggle diffview files panel' },
            {
                ']C',
                function()
                    require('diffview.config').actions.next_conflict()
                end,
                desc = 'Jump to next conflict marker'
            },
            {
                '[C',
                function()
                    require('diffview.config').actions.prev_conflict()
                end,
                desc = 'Jump to previous conflict marker'
            }
        }
    },
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add          = { text = '│' },
                change       = { text = '│' },
                delete       = { text = '_' },
                topdelete    = { text = '‾' },
                changedelete = { text = '~' },
                untracked    = { text = '┆' },
            },
            signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
            numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
            linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
            word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
            watch_gitdir = {
                interval = 1000,
                follow_files = true
            },
            attach_to_untracked = true,
            current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
                ignore_whitespace = false,
            },
            current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
            sign_priority = 6,
            update_debounce = 100,
            status_formatter = nil, -- Use default
            max_file_length = 40000, -- Disable if file is longer than this (in lines)
            preview_config = {
                -- Options passed to nvim_open_win
                border = 'single',
                style = 'minimal',
                relative = 'cursor',
                row = 0,
                col = 1
            },
            yadm = {
                enable = false
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']h', function()
                    if vim.wo.diff then return ']h' end
                    vim.schedule(function() gs.next_hunk() end)
                    return '<Ignore>'
                end, {expr=true})

                map('n', '[h', function()
                    if vim.wo.diff then return '[h' end
                    vim.schedule(function() gs.prev_hunk() end)
                    return '<Ignore>'
                end, {expr=true})

                -- Actions
                map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
                map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
                map('n', '<leader>hS', gs.stage_buffer)
                map('n', '<leader>hu', gs.undo_stage_hunk)
                map('n', '<leader>hR', gs.reset_buffer)
                map('n', '<leader>hp', gs.preview_hunk)
                map('n', '<leader>hb', function() gs.blame_line{full=true} end)
                map('n', '<leader>tb', gs.toggle_current_line_blame)
                map('n', '<leader>hd', gs.diffthis)
                map('n', '<leader>hD', function() gs.diffthis('~') end)
                map('n', '<leader>td', gs.toggle_deleted)

                -- Text object
                map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
            end
        }
    }
}
