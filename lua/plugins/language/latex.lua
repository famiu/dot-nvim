return {
    {
        'lervag/vimtex',
        ft = 'tex',
        init = function()
            vim.g.vimtex_view_method = 'zathura_simple'
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
            vim.g.vimtex_syntax_conceal = {
                accents = 1,
                ligatures = 1,
                cites = 1,
                fancy = 1,
                spacing = 0,
                greek = 1,
                math_bounds = 1,
                math_delimiters = 1,
                math_fracs = 1,
                math_super_sub = 1,
                math_symbols = 1,
                sections = 0,
                styles = 1,
            }
        end,
    },
}
