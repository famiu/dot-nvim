-- nvim-cmp configuration
local api = vim.api
local fn = vim.fn
local cmp = require('cmp')
local luasnip = require('luasnip')

local has_words_before = function()
    local line, col = unpack(api.nvim_win_get_cursor(0))
    return col ~= 0 and api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },

    mapping = cmp.mapping.preset.insert {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif has_words_before() and luasnip.expand_or_jumpable() then
                api.nvim_feedkeys(
                api.nvim_replace_termcodes(
                '<Plug>luasnip-expand-or-jump',
                true, true, true
                ), '', true
                )
            else
                fallback()
            end
        end,

        ['<S-Tab>'] = function()
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                api.nvim_feedkeys(
                api.nvim_replace_termcodes(
                '<Plug>luasnip-jump-prev',
                true, true, true
                ), '', true
                )
            end
        end
    },

    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip' },
    },

    formatting = {
        format = function(entry, vim_item)
            vim_item.menu = ({
                path = "[Path]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[Lua]",
                luasnip = "[LuaSnip]",
            })[entry.source.name]
            vim_item.kind = vim.lsp.protocol.CompletionItemKind[vim_item.kind]

            return vim_item
        end
    }
}
