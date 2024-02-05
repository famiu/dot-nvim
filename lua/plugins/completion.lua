local kind_icons = {
    Text          = '',
    Method        = '',
    Function      = '',
    Constructor   = '',
    Field         = 'ﰠ',
    Variable      = '',
    Class         = 'ﴯ',
    Interface     = '',
    Module        = '',
    Property      = 'ﰠ',
    Unit          = '塞',
    Value         = '',
    Enum          = '',
    Keyword       = '',
    Snippet       = '',
    Color         = '',
    File          = '',
    Reference     = '',
    Folder        = '',
    EnumMember    = '',
    Constant      = '',
    Struct        = 'פּ',
    Event         = '',
    Operator      = '',
    TypeParameter = '',
}

return {
    { 'folke/neodev.nvim', lazy = true, opts = { lspconfig = false } },
    { 'L3MON4D3/LuaSnip', lazy = true },
    {
        'zbirenbaum/copilot.lua',
        cmd = 'Copilot',
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
        },
    },
    {
        'zbirenbaum/copilot-cmp',
        dependencies = 'zbirenbaum/copilot.lua',
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

            local has_words_before = function()
                local linenr, colnr = unpack(vim.api.nvim_win_get_cursor(0))
                local line = vim.api.nvim_buf_get_lines(0, linenr - 1, linenr, true)[1]
                return colnr ~= 0 and line:sub(colnr, colnr):match('%s') == nil
            end

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
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
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
