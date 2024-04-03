return {
    lua_ls = {
        cmd = { 'lua-language-server' },
        settings = {
            Lua = {
                workspace = {
                    checkThirdParty = false,
                },
            },
        },
        on_init = function(client)
            local nvim_runtime_dirs = vim.api.nvim_get_runtime_file('', true)
            local is_nvim_lua = false

            if require('utilities.os').is_windows() then
                -- Use forward slashes for Windows paths in runtime_dirs since root_dir uses forward slashes.
                for i, dir in ipairs(nvim_runtime_dirs) do
                    nvim_runtime_dirs[i] = dir:gsub('\\', '/')
                end
            end

            -- Check if the root_dir is inside a Neovim runtime directory.
            for _, dir in ipairs(nvim_runtime_dirs) do
                if vim.startswith(client.config.root_dir, dir) then
                    is_nvim_lua = true
                    break
                end
            end

            if not is_nvim_lua then
                return
            end

            local workspace_libraries = nvim_runtime_dirs
            -- Add busted and luv to the workspace library.
            table.insert(workspace_libraries, '${3rd}/luv/library')
            table.insert(workspace_libraries, '${3rd}/busted/library')

            client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                runtime = {
                    version = 'LuaJIT',
                },
                -- Make the server aware of Neovim runtime files.
                workspace = {
                    library = workspace_libraries,
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
