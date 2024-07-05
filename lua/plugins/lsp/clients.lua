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
    bashls = {
        filetypes = { 'sh', 'bash', 'zsh' },
    },
    cmake = {
        cmd = { 'cmake-language-server' },
    },
    basedpyright = {},
}
