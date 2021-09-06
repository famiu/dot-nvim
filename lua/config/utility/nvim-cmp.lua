-- nvim-cmp configuration
local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup {
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },

    mapping = {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })
    },

    sources = {
        -- { name = 'buffer' },
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'vsnip' },
        { name = 'calc' }
    },

    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind]
            vim_item.menu = ({
                buffer = "[Buffer]",
                path = "[Path]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[Lua]",
                vsnip = "[VSnip]",
                calc = "[Calc]",
            })[entry.source.name]
            return vim_item
        end,
    },
}
