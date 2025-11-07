return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        input = { enabled = true },
        notifier = {
            enabled = true,
            timeout = 3000,
        },
        picker = { enabled = true },
        quickfile = { enabled = true },
        scope = { enabled = true },
        words = { enabled = true },
        styles = {
            notification = {
                wo = { wrap = true }, -- Wrap notifications
            },
        },
        statuscolumn = {
            left = { 'fold', 'sign', 'mark' },
            right = { 'git' },
            folds = {
                open = false,
                git_hl = false,
            },
            git = {
                patterns = { 'GitSign', 'MiniDiffSign' },
            },
            refresh = 50,
        },
        indent = { enabled = true },
    },
    keys = {
        -- Top Pickers & Explorer
        {
            '<Leader><space>',
            function()
                Snacks.picker.smart()
            end,
            desc = 'Smart Find Files',
        },
        {
            '<Leader>,',
            function()
                Snacks.picker.buffers()
            end,
            desc = 'Buffers',
        },
        {
            '<Leader>/',
            function()
                Snacks.picker.grep()
            end,
            desc = 'Grep',
        },
        {
            '<Leader>:',
            function()
                Snacks.picker.command_history()
            end,
            desc = 'Command History',
        },
        {
            '<Leader>n',
            function()
                Snacks.picker.notifications()
            end,
            desc = 'Notification History',
        },
        {
            '<Leader>fc',
            function()
                Snacks.picker.files({ cwd = vim.fn.stdpath('config') })
            end,
            desc = 'Find Config File',
        },
        {
            '<Leader>ff',
            function()
                Snacks.picker.files()
            end,
            desc = 'Find Files',
        },
        {
            '<Leader>fg',
            function()
                Snacks.picker.git_files()
            end,
            desc = 'Find Git Files',
        },
        {
            '<Leader>fr',
            function()
                Snacks.picker.recent()
            end,
            desc = 'Recent',
        },
        -- git
        {
            '<Leader>gb',
            function()
                Snacks.picker.git_branches()
            end,
            desc = 'Git Branches',
        },
        {
            '<Leader>gl',
            function()
                Snacks.picker.git_log()
            end,
            desc = 'Git Log',
        },
        {
            '<Leader>gL',
            function()
                Snacks.picker.git_log_line()
            end,
            desc = 'Git Log Line',
        },
        {
            '<Leader>gf',
            function()
                Snacks.picker.git_log_file()
            end,
            desc = 'Git Log File',
        },
        -- Grep
        {
            '<Leader>sb',
            function()
                Snacks.picker.lines()
            end,
            desc = 'Buffer Lines',
        },
        {
            '<Leader>sB',
            function()
                Snacks.picker.grep_buffers()
            end,
            desc = 'Grep Open Buffers',
        },
        {
            '<Leader>sg',
            function()
                Snacks.picker.grep()
            end,
            desc = 'Grep',
        },
        {
            '<Leader>sw',
            function()
                Snacks.picker.grep_word()
            end,
            desc = 'Visual selection or word',
            mode = { 'n', 'x' },
        },
        -- search
        {
            '<Leader>s"',
            function()
                Snacks.picker.registers()
            end,
            desc = 'Registers',
        },
        {
            '<Leader>s/',
            function()
                Snacks.picker.search_history()
            end,
            desc = 'Search History',
        },
        {
            '<Leader>sa',
            function()
                Snacks.picker.autocmds()
            end,
            desc = 'Autocmds',
        },
        {
            '<Leader>sc',
            function()
                Snacks.picker.commands()
            end,
            desc = 'Commands',
        },
        {
            '<Leader>sd',
            function()
                Snacks.picker.diagnostics()
            end,
            desc = 'Diagnostics',
        },
        {
            '<Leader>sD',
            function()
                Snacks.picker.diagnostics_buffer()
            end,
            desc = 'Buffer Diagnostics',
        },
        {
            '<Leader>sh',
            function()
                Snacks.picker.help()
            end,
            desc = 'Help Pages',
        },
        {
            '<Leader>sH',
            function()
                Snacks.picker.highlights()
            end,
            desc = 'Highlights',
        },
        {
            '<Leader>si',
            function()
                Snacks.picker.icons()
            end,
            desc = 'Icons',
        },
        {
            '<Leader>sj',
            function()
                Snacks.picker.jumps()
            end,
            desc = 'Jumps',
        },
        {
            '<Leader>sk',
            function()
                Snacks.picker.keymaps()
            end,
            desc = 'Keymaps',
        },
        {
            '<Leader>sl',
            function()
                Snacks.picker.loclist()
            end,
            desc = 'Location List',
        },
        {
            '<Leader>sm',
            function()
                Snacks.picker.marks()
            end,
            desc = 'Marks',
        },
        {
            '<Leader>sM',
            function()
                Snacks.picker.man()
            end,
            desc = 'Man Pages',
        },
        {
            '<Leader>sp',
            function()
                Snacks.picker.lazy()
            end,
            desc = 'Search for Plugin Spec',
        },
        {
            '<Leader>sq',
            function()
                Snacks.picker.qflist()
            end,
            desc = 'Quickfix List',
        },
        {
            '<Leader>sR',
            function()
                Snacks.picker.resume()
            end,
            desc = 'Resume',
        },
        {
            '<Leader>su',
            function()
                Snacks.picker.undo()
            end,
            desc = 'Undo History',
        },
        {
            '<Leader>uC',
            function()
                Snacks.picker.colorschemes()
            end,
            desc = 'Colorschemes',
        },
        -- LSP
        {
            '<Leader>ss',
            function()
                Snacks.picker.lsp_symbols()
            end,
            desc = 'LSP Symbols',
        },
        {
            '<Leader>sS',
            function()
                Snacks.picker.lsp_workspace_symbols()
            end,
            desc = 'LSP Workspace Symbols',
        },
        -- Other
        {
            '<Leader>gg',
            function()
                Snacks.lazygit.open()
            end,
            desc = 'Lazygit',
        },
        {
            '<Leader>n',
            function()
                Snacks.notifier.show_history()
            end,
            desc = 'Notification History',
        },
        {
            '<Leader>bd',
            function()
                Snacks.bufdelete()
            end,
            desc = 'Delete Buffer',
        },
        {
            '<Leader>cR',
            function()
                Snacks.rename.rename_file()
            end,
            desc = 'Rename File',
        },
        {
            '<Leader>un',
            function()
                Snacks.notifier.hide()
            end,
            desc = 'Dismiss All Notifications',
        },
        {
            '<Leader>N',
            desc = 'Neovim News',
            function()
                Snacks.win({
                    file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
                    width = 0.6,
                    height = 0.6,
                    wo = {
                        spell = false,
                        wrap = false,
                        signcolumn = 'yes',
                        statuscolumn = ' ',
                        conceallevel = 3,
                    },
                })
            end,
        },
        {
            '<c-/>',
            function()
                Snacks.terminal()
            end,
            desc = 'Toggle Terminal',
        },
        {
            ']r',
            function()
                Snacks.words.jump(vim.v.count1)
            end,
            desc = 'Next Reference',
            mode = { 'n' },
        },
        {
            '[r',
            function()
                Snacks.words.jump(-vim.v.count1)
            end,
            desc = 'Prev Reference',
            mode = { 'n' },
        },
    },
    init = function()
        vim.api.nvim_create_autocmd('User', {
            pattern = 'VeryLazy',
            callback = function()
                -- Setup some globals for debugging (lazy-loaded)
                _G.dd = function(...)
                    Snacks.debug.inspect(...)
                end
                _G.bt = function()
                    Snacks.debug.backtrace()
                end
                vim.print = _G.dd -- Override print to use snacks for `:=` command

                -- Create some toggle mappings
                Snacks.toggle.option('spell', { name = 'Spelling' }):map('<Leader>us')
                Snacks.toggle.option('wrap', { name = 'Wrap' }):map('<Leader>uw')
                Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map('<Leader>uL')
                Snacks.toggle.diagnostics():map('<Leader>ud')
                Snacks.toggle.line_number():map('<Leader>ul')
                Snacks.toggle
                    .option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
                    :map('<Leader>uc')
                Snacks.toggle.treesitter():map('<Leader>uT')
                Snacks.toggle
                    .option('background', { off = 'light', on = 'dark', name = 'Dark Background' })
                    :map('<Leader>ub')
                Snacks.toggle.inlay_hints():map('<Leader>uh')
                Snacks.toggle.indent():map('<Leader>ug')
                Snacks.toggle.dim():map('<Leader>uD')

                -- Rename support for Oil.nvim
                vim.api.nvim_create_autocmd('User', {
                    pattern = 'OilActionsPost',
                    callback = function(event)
                        if event.data.actions.type == 'move' then
                            Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
                        end
                    end,
                })
            end,
        })
    end,
    config = function(_, opts)
        require('snacks').setup(opts)

        vim.api.nvim_create_autocmd('LspProgress', {
            ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
            callback = function(ev)
                local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
                vim.notify(vim.lsp.status(), 'info', {
                    id = 'lsp_progress',
                    title = 'LSP Progress',
                    opts = function(notif)
                        notif.icon = ev.data.params.value.kind == 'end' and ' '
                            or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
                    end,
                })
            end,
        })
    end,
}
