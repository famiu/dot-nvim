-- Tree-sitter
require('nvim-treesitter.configs').setup {
    ensure_installed = {
        'c',
        'cpp',
        'cmake',
        'python',
        'rust',
        'bash',
        'lua',
        'toml',
        'latex'
    },
    highlight = {
        enable = true,
        disable = {},
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        }
    },
    indent = {
        enable = false
    },
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            }
        },
    },
}
