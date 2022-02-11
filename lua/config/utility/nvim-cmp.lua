-- nvim-cmp configuration
local api = vim.api
local fn = vim.fn
local cmp = require('cmp')
local lspkind = require('lspkind')
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

    mapping = {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ['<Tab>'] = cmp.mapping(
            function(fallback)
                if fn.pumvisible() == 1 then
                    api.nvim_feedkeys(
                        api.nvim_replace_termcodes(
                            '<C-n>',
                            true, true, true
                        ), 'n', true
                    )
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
            end, { 'i', 's' }
        ),

        ['<S-Tab>'] = cmp.mapping(
            function()
                if fn.pumvisible() == 1 then
                    api.nvim_feedkeys(
                        api.nvim_replace_termcodes(
                            '<C-p>',
                            true, true, true
                        ), 'n', true
                    )
                elseif luasnip.jumpable(-1) then
                    api.nvim_feedkeys(
                        api.nvim_replace_termcodes(
                            '<Plug>luasnip-jump-prev',
                            true, true, true
                        ), '', true
                    )
                end
            end, { 'i', 's' }
        ),
    },

    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip' },
    },

    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol_text', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

            before = function(entry, vim_item)
                vim_item.menu = ({
                    path = "[Path]",
                    nvim_lsp = "[LSP]",
                    nvim_lua = "[Lua]",
                    luasnip = "[LuaSnip]",
                })[entry.source.name]
                return vim_item
            end,
        })
    }
}
