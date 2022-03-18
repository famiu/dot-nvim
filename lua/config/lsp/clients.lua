local bind = vim.api.nvim_buf_set_keymap
local utils = require('utils')
local lsputils = require('config.lsp.utils')

-- Client setup
lsputils.clients['clangd'].setup {
    on_attach = function(client, bufnr)
        lsputils.default_on_attach(client, bufnr)

        bind(
            bufnr, 'n', '<Leader>lh',
            '<cmd>ClangdSwitchSourceHeader<CR>',
            { noremap = true, silent = true }
        )
    end
}

lsputils.clients['rust_analyzer'].setup {
    on_attach = function(client, bufnr)
        lsputils.default_on_attach(client, bufnr)

        bind(bufnr, 'n', '<Leader>lR', '<cmd>CargoReload<CR>', { noremap = true, silent = true })
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
}

lsputils.clients['sumneko_lua'].setup {
    cmd = {'lua-language-server'},
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
}

lsputils.clients['pyright'].setup {
    on_attach = function(client, bufnr)
        lsputils.default_on_attach(client, bufnr)


        bind(
            bufnr, 'n', '<Leader>lo',
            '<cmd>PyrightOrganizeImports<CR>',
            { noremap = true, silent = true }
        )
    end
}

lsputils.clients['texlab'].setup {
    on_attach = function(client, bufnr)
        lsputils.default_on_attach(client, bufnr)

        local opts = { noremap = true, silent = true }

        -- Preview on save
        utils.create_buf_augroup({
            {
                event = 'BufWritePost',
                opts = { command = 'TexlabForward' }
            }
        }, 'texlab_preview_on_save', bufnr)

        bind(bufnr, 'n', '<Leader>lb', '<cmd>TexlabBuild<CR>', opts)
        bind(bufnr, 'n', '<Leader>lp', '<cmd>TexlabForward<CR>', opts)
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
}

lsputils.clients['bashls'].setup {}
lsputils.clients['gdscript'].setup {}
