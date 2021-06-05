local utils = require('utils')
local lsputils = require('config.lsp.utils')

-- Path where lspinstall installs LSP servers
local lspinstall_path = vim.fn.stdpath('data') .. '/lspinstall/'

-- Client setup
lsputils.setup_client('clangd', {
    on_attach = function(client, bufnr)
        lsputils.default_on_attach(client, bufnr)

        local opts = { noremap = true, silent = true }

        lsputils.client_add_binds(
            bufnr,
            {{'n', '<Leader>lh', '<cmd>ClangdSwitchSourceHeader<CR>', opts}},
            { h = 'Switch source/header' },
            { prefix = '<leader>l' }
        )
    end
})

lsputils.setup_client('rust_analyzer', {
    on_attach = function(client, bufnr)
        lsputils.default_on_attach(client, bufnr)

        local opts = { noremap = true, silent = true }

        lsputils.client_add_binds(
            bufnr,
            {{'n', '<Leader>lR', '<cmd>CargoReload<CR>', opts}},
            { R = 'Reload workspace' },
            { prefix = '<leader>l' }
        )
    end,
    settings = {
        ['rust-analyzer'] = {
            assist = {
                importMergeBehavior = "last",
                importPrefix = "by_self",
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
        }
    }
})

lsputils.setup_client('sumneko_lua', {
    cmd = {
        lspinstall_path .. 'lua/sumneko-lua-language-server',
        '-E', lspinstall_path .. 'lua/main.lua'
    },
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';'),
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                },
            },
        },
    }
})

lsputils.setup_client('pyright', {
    on_attach = function(client, bufnr)
        lsputils.default_on_attach(client, bufnr)

        local opts = { noremap = true, silent = true }

        lsputils.client_add_binds(
            bufnr,
            {{'n', '<Leader>lo', '<cmd>PyrightOrganizeImports<CR>', opts}},
            { o = 'Organize imports' },
            { prefix = '<leader>l' }
        )
    end
})

lsputils.setup_client('cmake', {
    cmd = {
        lspinstall_path .. 'cmake/venv/bin/cmake-language-server'
    }
})

lsputils.setup_client('texlab', {
    on_attach = function(client, bufnr)
        lsputils.default_on_attach(client, bufnr)

        local opts = { noremap = true, silent = true }

        -- Preview on save
        utils.create_buf_augroup({
            {
                'BufWritePost',
                'TexlabForward'
            }
        }, 'texlab_preview_on_save', bufnr)

        lsputils.client_add_binds(
            bufnr,
            {
                {'n', '<Leader>lb', '<cmd>TexlabBuild<CR>', opts},
                {'n', '<Leader>lp', '<cmd>TexlabForward<CR>', opts}
            },
            { b = 'Build', p = 'Preview' },
            { prefix = '<leader>l' }
        )
    end,

    filetypes = { 'tex', 'plaintex', 'bib' },

    settings = {
        texlab = {
            build = {
                executable = 'latexmk',
                args = { '-pdf', '-interaction=nonstopmode', '-synctex=1', '-pvc', '%f' },
                isContinuous = true,
            },
            chktex = {
                onEdit = false,
                onOpenAndSave = true,
            },
            formatterLineLength = 100,
            forwardSearch = {
                executable = 'okular',
                args = { '--unique', '%p#src:%l%f' }
            }
        }
    }
})

lsputils.setup_client('bashls')
lsputils.setup_client('gdscript')
