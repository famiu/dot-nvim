local lsp_kind_icons = {
    Text = '󰉿',
    Method = '󰆧',
    Function = '󰊕',
    Constructor = '',
    Field = '󰜢',
    Variable = '󰀫',
    Class = '󰠱',
    Interface = '',
    Module = '',
    Property = '󰜢',
    Unit = '󰑭',
    Value = '󰎠',
    Enum = '',
    Keyword = '󰌋',
    Snippet = '',
    Color = '󰏘',
    File = '󰈙',
    Reference = '󰈇',
    Folder = '󰉋',
    EnumMember = '',
    Constant = '󰏿',
    Struct = '󰙅',
    Event = '',
    Operator = '󰆕',
    TypeParameter = '',
}

return {
    {
        'mfussenegger/nvim-lsp-compl',
        config = function()
            -- Update default Lspconfig capabilities.
            require('lspconfig').util.default_config.capabilities = vim.tbl_deep_extend(
                'force',
                vim.lsp.protocol.make_client_capabilities(),
                require('lsp_compl').capabilities()
            )

            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'Enable nvim-lsp-compl',
                group = vim.api.nvim_create_augroup('ConfigCompletion', {}),
                callback = function(args)
                    local buf = args.buf
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    assert(client ~= nil)

                    require('lsp_compl').attach(client, buf, {
                        trigger_on_delete = true,
                        server_side_fuzzy_completion = true,
                    })

                    -- Snippet keymaps
                    vim.keymap.set('i', '<C-y>', function()
                        if vim.fn.pumvisible() == 1 then
                            require('lsp_compl').accept_pum()
                        end
                        return '<C-y>'
                    end, { buffer = buf, expr = true })
                    vim.keymap.set({ 'i', 's' }, '<C-l>', function()
                        vim.snippet.jump(1)
                    end, { buffer = buf, silent = true })
                    vim.keymap.set({ 'i', 's' }, '<C-h>', function()
                        vim.snippet.jump(-1)
                    end, { buffer = buf, silent = true })
                end,
            })
        end,
    },
}
