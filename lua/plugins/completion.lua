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
        'L3MON4D3/LuaSnip',
        lazy = true,
        dependencies = { 'rafamadriz/friendly-snippets' },
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'neovim/nvim-lspconfig',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
        },
        event = 'InsertEnter',
        config = function()
            -- Set up nvim-cmp.
            local cmp = require('cmp')
            local luasnip = require('luasnip')
            local default_capabilities = require('cmp_nvim_lsp').default_capabilities()

            -- Update default Lspconfig capabilities.
            require('lspconfig').util.default_config.capabilities = default_capabilities

            cmp.setup({
                snippet = {
                    expand = function(args) luasnip.lsp_expand(args.body) end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-e>'] = cmp.mapping.abort(),
                    -- <C-l> for accepting snippets and jumping forward, <C-h> for jumping backwards.
                    ['<C-l>'] = cmp.mapping(function()
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        end
                    end, { 'i', 's' }),
                    ['<C-h>'] = cmp.mapping(function()
                        if luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        end
                    end, { 'i', 's' }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                }, {
                    { name = 'buffer' },
                }),
                formatting = {
                    format = function(_, vim_item)
                        vim_item.kind = lsp_kind_icons[vim_item.kind] .. ' ' .. vim_item.kind
                        return vim_item
                    end,
                },
                sorting = {
                    priority_weight = 2,
                    comparators = {
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.score,
                        cmp.config.compare.recently_used,
                        cmp.config.compare.locality,
                        cmp.config.compare.kind,
                        -- The scopes comparator is disabled because it's too slow for large files
                        -- cmp.config.compare.scopes,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                    },
                },
                experimental = {
                    ghost_text = true,
                },
            })

            cmp.setup.filetype('tex', {
                sources = {
                    { name = 'vimtex' },
                    { name = 'buffer' },
                },
            })
        end,
    },
}
