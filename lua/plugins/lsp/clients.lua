return {
    lua_ls = {
        cmd = { 'lua-language-server' },
        settings = {
            Lua = {},
        },
        on_init = function(client)
            if client.config.root_dir == nil then
                return
            end

            local path = vim.fs.normalize(client.config.root_dir)

            local nvim_runtime_dirs = vim.tbl_map(
                function(dir) return vim.fs.normalize(dir) end,
                vim.api.nvim_list_runtime_paths()
            )

            local in_nvim_runtime = false

            for _, dir in ipairs(nvim_runtime_dirs) do
                if vim.startswith(path, dir) then
                    in_nvim_runtime = true
                    break
                end
            end

            if not in_nvim_runtime then
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
                        unpack(nvim_runtime_dirs),
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
    pyright = {},
}
