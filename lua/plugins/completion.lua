local kind_icons = {
    Text          = '󰉿',
    Method        = '󰆧',
    Function      = '󰊕',
    Constructor   = '',
    Field         = '󰜢',
    Variable      = '󰀫',
    Class         = '󰠱',
    Interface     = '',
    Module        = '',
    Property      = '󰜢',
    Unit          = '󰑭',
    Value         = '󰎠',
    Enum          = '',
    Keyword       = '󰌋',
    Snippet       = '',
    Color         = '󰏘',
    File          = '󰈙',
    Reference     = '󰈇',
    Folder        = '󰉋',
    EnumMember    = '',
    Constant      = '󰏿',
    Struct        = '󰙅',
    Event         = '',
    Operator      = '󰆕',
    TypeParameter = '',
}

return {
    { 'L3MON4D3/LuaSnip', lazy = true },
    {
        'zbirenbaum/copilot.lua',
        cmd = 'Copilot',
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
        },
        dependencies = { 'rafamadriz/friendly-snippets' },
    },
    {
        'zbirenbaum/copilot-cmp',
        dependencies = { 'zbirenbaum/copilot.lua' },
        opts = {},
        config = function(_, opts)
            kind_icons.Copilot = ''
            require('copilot_cmp').setup(opts)

            -- Add highlight for Copilot items in nvim-cmp.
            vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
        end
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'zbirenbaum/copilot-cmp',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
        },
        config = function()
            -- Set up nvim-cmp.
            local cmp = require('cmp')
            local luasnip = require('luasnip')

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
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
                    { name = 'copilot' },
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                }, {
                    { name = 'buffer' },
                }),
                formatting = {
                    format = function(_, vim_item)
                        vim_item.kind = kind_icons[vim_item.kind] .. ' ' .. vim_item.kind
                        return vim_item
                    end
                },
                sorting = {
                    priority_weight = 2,
                    comparators = {
                        require("copilot_cmp.comparators").prioritize,

                        -- Below is the default comparitor list and order for nvim-cmp
                        cmp.config.compare.offset,
                        -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
                        cmp.config.compare.exact,
                        cmp.config.compare.score,
                        cmp.config.compare.recently_used,
                        cmp.config.compare.locality,
                        cmp.config.compare.kind,
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
                }
            })
        end
    }
}
