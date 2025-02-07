return {
    lua_ls = {
        cmd = { 'lua-language-server' },
        settings = {
            Lua = {},
        },
        on_init = function(client)
            if not client.workspace_folders then
                return
            end

            local path = vim.fs.normalize(client.workspace_folders[1].name)

            if path == nil or vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc') then
                return
            end

            client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                runtime = {
                    -- Use LuaJIT for Neovim.
                    version = 'LuaJIT',
                },
                -- Make the server aware of Neovim runtime files.
                workspace = {
                    checkThirdParty = false,
                    library = {
                        '${3rd}/luv/library',
                        '${3rd}/busted/library',
                        unpack(vim.api.nvim_list_runtime_paths()),
                    },
                },
            })
        end,
    },
    clangd = {
        cmd = { 'clangd', '--background-index', '--clang-tidy' },
    },
    rust_analyzer = {
        settings = {
            ['rust-analyzer'] = {
                check = {
                    command = 'clippy',
                },
                diagnostics = {
                    experimental = {
                        enable = true,
                    },
                },
                rustfmt = {
                    extraArgs = { '+nightly' },
                    rangeFormatting = {
                        enable = true,
                    },
                },
            },
        },
    },
    texlab = {
        settings = {
            texlab = {
                bibtexFormatter = 'texlab',
                build = {
                    args = {
                        '-pdf',
                        '-pdflatex=lualatex',
                        '-aux-directory=aux',
                        '-interaction=nonstopmode',
                        '-synctex=1',
                        '%f',
                    },
                    executable = 'latexmk',
                    forwardSearchAfter = true,
                    onSave = true,
                },
                chktex = {
                    onEdit = false,
                    onOpenAndSave = false,
                },
                diagnosticsDelay = 300,
                formatterLineLength = 80,
                forwardSearch = {
                    executable = 'zathura',
                    args = { '--synctex-forward', '%l:1:%f', '%p' },
                    onSave = true,
                },
                forwardSearchAfter = true,
                latexFormatter = 'latexindent',
                latexindent = {
                    modifyLineBreaks = false,
                },
            },
        },
    },
    sourcekit = {
        filetypes = { 'swift' },
        settings = {
            sourcekit = {
                backgroundIndexing = true,
                backgroundPreparationMode = 'enabled',
            },
        },
    },
    cmake = {},
    basedpyright = {},
    ruff = {},
    gopls = {},
    asm_lsp = {},
    ts_ls = {},
    cssls = {},
    html = {},
    svelte = {},
}
