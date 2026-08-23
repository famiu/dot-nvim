vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

require('conform').setup({
    formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'ruff' },
        css = { 'prettier' },
        html = { 'prettier' },
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        json = { 'prettier' },
        jsonc = { 'prettier' },
        markdown = { 'prettier' },
    },
})

vim.keymap.set({ 'n', 'x' }, '<Leader>F', function()
    require('conform').format({ async = true, lsp_format = 'first' })
end)
