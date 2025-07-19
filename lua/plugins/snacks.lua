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
    },
    keys = {
        -- Top Pickers & Explorer
        {
            '<leader><space>',
            function()
                Snacks.picker.smart()
            end,
            desc = 'Smart Find Files',
        },
        {
            '<leader>,',
            function()
                Snacks.picker.buffers()
            end,
            desc = 'Buffers',
        },
        {
            '<leader>/',
            function()
                Snacks.picker.grep()
            end,
            desc = 'Grep',
        },
        {
            '<leader>:',
            function()
                Snacks.picker.command_history()
            end,
            desc = 'Command History',
        },
        {
            '<leader>n',
            function()
                Snacks.picker.notifications()
            end,
            desc = 'Notification History',
        },
        {
            '<leader>fc',
            function()
                Snacks.picker.files({ cwd = vim.fn.stdpath('config') })
            end,
            desc = 'Find Config File',
        },
        {
            '<leader>ff',
            function()
                Snacks.picker.files()
            end,
            desc = 'Find Files',
        },
        {
            '<leader>fg',
            function()
                Snacks.picker.git_files()
            end,
            desc = 'Find Git Files',
        },
        {
            '<leader>fr',
            function()
                Snacks.picker.recent()
            end,
            desc = 'Recent',
        },
        -- git
        {
            '<leader>gb',
            function()
                Snacks.picker.git_branches()
            end,
            desc = 'Git Branches',
        },
        {
            '<leader>gl',
            function()
                Snacks.picker.git_log()
            end,
            desc = 'Git Log',
        },
        {
            '<leader>gL',
            function()
                Snacks.picker.git_log_line()
            end,
            desc = 'Git Log Line',
        },
        {
            '<leader>gf',
            function()
                Snacks.picker.git_log_file()
            end,
            desc = 'Git Log File',
        },
        -- Grep
        {
            '<leader>sb',
            function()
                Snacks.picker.lines()
            end,
            desc = 'Buffer Lines',
        },
        {
            '<leader>sB',
            function()
                Snacks.picker.grep_buffers()
            end,
            desc = 'Grep Open Buffers',
        },
        {
            '<leader>sg',
            function()
                Snacks.picker.grep()
            end,
            desc = 'Grep',
        },
        {
            '<leader>sw',
            function()
                Snacks.picker.grep_word()
            end,
            desc = 'Visual selection or word',
            mode = { 'n', 'x' },
        },
        -- search
        {
            '<leader>s"',
            function()
                Snacks.picker.registers()
            end,
            desc = 'Registers',
        },
        {
            '<leader>s/',
            function()
                Snacks.picker.search_history()
            end,
            desc = 'Search History',
        },
        {
            '<leader>sa',
            function()
                Snacks.picker.autocmds()
            end,
            desc = 'Autocmds',
        },
        {
            '<leader>sc',
            function()
                Snacks.picker.commands()
            end,
            desc = 'Commands',
        },
        {
            '<leader>sd',
            function()
                Snacks.picker.diagnostics()
            end,
            desc = 'Diagnostics',
        },
        {
            '<leader>sD',
            function()
                Snacks.picker.diagnostics_buffer()
            end,
            desc = 'Buffer Diagnostics',
        },
        {
            '<leader>sh',
            function()
                Snacks.picker.help()
            end,
            desc = 'Help Pages',
        },
        {
            '<leader>sH',
            function()
                Snacks.picker.highlights()
            end,
            desc = 'Highlights',
        },
        {
            '<leader>si',
            function()
                Snacks.picker.icons()
            end,
            desc = 'Icons',
        },
        {
            '<leader>sj',
            function()
                Snacks.picker.jumps()
            end,
            desc = 'Jumps',
        },
        {
            '<leader>sk',
            function()
                Snacks.picker.keymaps()
            end,
            desc = 'Keymaps',
        },
        {
            '<leader>sl',
            function()
                Snacks.picker.loclist()
            end,
            desc = 'Location List',
        },
        {
            '<leader>sm',
            function()
                Snacks.picker.marks()
            end,
            desc = 'Marks',
        },
        {
            '<leader>sM',
            function()
                Snacks.picker.man()
            end,
            desc = 'Man Pages',
        },
        {
            '<leader>sp',
            function()
                Snacks.picker.lazy()
            end,
            desc = 'Search for Plugin Spec',
        },
        {
            '<leader>sq',
            function()
                Snacks.picker.qflist()
            end,
            desc = 'Quickfix List',
        },
        {
            '<leader>sR',
            function()
                Snacks.picker.resume()
            end,
            desc = 'Resume',
        },
        {
            '<leader>su',
            function()
                Snacks.picker.undo()
            end,
            desc = 'Undo History',
        },
        {
            '<leader>uC',
            function()
                Snacks.picker.colorschemes()
            end,
            desc = 'Colorschemes',
        },
        -- LSP
        {
            '<leader>ss',
            function()
                Snacks.picker.lsp_symbols()
            end,
            desc = 'LSP Symbols',
        },
        {
            '<leader>sS',
            function()
                Snacks.picker.lsp_workspace_symbols()
            end,
            desc = 'LSP Workspace Symbols',
        },
        -- Other
        {
            '<leader>n',
            function()
                Snacks.notifier.show_history()
            end,
            desc = 'Notification History',
        },
        {
            '<leader>bd',
            function()
                Snacks.bufdelete()
            end,
            desc = 'Delete Buffer',
        },
        {
            '<leader>cR',
            function()
                Snacks.rename.rename_file()
            end,
            desc = 'Rename File',
        },
        {
            '<leader>un',
            function()
                Snacks.notifier.hide()
            end,
            desc = 'Dismiss All Notifications',
        },
        {
            '<leader>N',
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
            mode = { 'n', 't' },
        },
        {
            '[r',
            function()
                Snacks.words.jump(-vim.v.count1)
            end,
            desc = 'Prev Reference',
            mode = { 'n', 't' },
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
                Snacks.toggle.option('spell', { name = 'Spelling' }):map('<leader>us')
                Snacks.toggle.option('wrap', { name = 'Wrap' }):map('<leader>uw')
                Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map('<leader>uL')
                Snacks.toggle.diagnostics():map('<leader>ud')
                Snacks.toggle.line_number():map('<leader>ul')
                Snacks.toggle
                    .option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
                    :map('<leader>uc')
                Snacks.toggle.treesitter():map('<leader>uT')
                Snacks.toggle
                    .option('background', { off = 'light', on = 'dark', name = 'Dark Background' })
                    :map('<leader>ub')
                Snacks.toggle.inlay_hints():map('<leader>uh')
                Snacks.toggle.indent():map('<leader>ug')
                Snacks.toggle.dim():map('<leader>uD')

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

        vim.api.nvim_create_autocmd("LspProgress", {
            ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
            callback = function(ev)
                local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
                vim.notify(vim.lsp.status(), "info", {
                    id = "lsp_progress",
                    title = "LSP Progress",
                    opts = function(notif)
                        notif.icon = ev.data.params.value.kind == "end" and " "
                            or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
                    end,
                })
            end,
        })
    end,
}
