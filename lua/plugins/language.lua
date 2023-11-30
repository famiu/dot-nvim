-- Language-specific plugins

return {
    {
        'lervag/vimtex',
        init = function()
            vim.g.vimtex_view_method = 'zathura_simple'
            vim.g.vimtex_view_forward_search_on_start = 0
            vim.g.vimtex_compiler_latexmk = {
                aux_dir = './aux/',
                out_dir = '',
                callback = true,
                continuous = true,
                executable = 'latexmk',
                hooks = {},
                options = {
                    '-verbose',
                    '-file-line-error',
                    '-synctex=1',
                    '-interaction=nonstopmode',
                },
            }
        end,
        dependencies = { 'micangl/cmp-vimtex' },
    },
}
