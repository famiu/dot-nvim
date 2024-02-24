-- LSP client configurations

local lsputils = require('lsp.utils')

lsputils.configure_lsp {
    name = 'clangd',
    ftpattern = { 'c', 'cpp' },
    cmd = { 'clangd', '--background-index', '--clang-tidy' },
    root_pattern = { 'compile_commands.json', '.git' },
}

lsputils.configure_lsp {
    name = 'rust-analyzer',
    ftpattern = 'rust',
    cmd = { 'rust-analyzer', '+nightly' },
    root_pattern = { 'Cargo.toml', '.git' },
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
}

lsputils.configure_lsp {
    name = 'pyright',
    ftpattern = 'python',
    cmd = { 'pyright-langserver', '--stdio' },
    root_pattern = { 'setup.py', 'requirements.txt', 'Pipfile', '.git' },
}

lsputils.configure_lsp {
    name = 'lua-language-server',
    ftpattern = 'lua',
    cmd = { 'lua-language-server' },
    root_pattern = '.git',
    settings = {
        Lua = {
            workspace = {
                checkThirdParty = false
            }
        },
    },
    before_init = function(_, config)
        -- Automatically add Lua runtime to workspace library for Neovim config.
        local root_dir = config.root_dir or ''
        local runtime_dirs = vim.api.nvim_get_runtime_file('', true)
        local is_nvim_lua = false

        if require('utilities.os').is_windows() then
            -- Use forward slashes for Windows paths in runtime_dirs since root_dir uses forward slashes.
            for i, dir in ipairs(runtime_dirs) do
                runtime_dirs[i] = dir:gsub('\\', '/')
            end
        end

        for _, dir in ipairs(runtime_dirs) do
            if vim.startswith(root_dir, dir) then
                is_nvim_lua = true
                break
            end
        end

        if is_nvim_lua then
            config.settings.Lua.runtime = {
                version = 'LuaJIT'
            }

            local workspace_libraries = runtime_dirs
            -- Add busted and luv to the workspace library.
            workspace_libraries[#workspace_libraries + 1] = '${3rd}/luv/library'
            workspace_libraries[#workspace_libraries + 1] = '${3rd}/busted/library'

            config.settings.Lua.workspace.library = workspace_libraries
        end
    end,
}

lsputils.configure_lsp {
    name = 'bash-language-server',
    ftpattern = { 'sh', 'bash', 'zsh' },
    cmd = { 'bash-language-server', 'start' },
    root_pattern = '.git',
}

lsputils.configure_lsp {
    name = 'cmake-language-server',
    ftpattern = 'cmake',
    cmd = { 'cmake-language-server' },
    root_pattern = '.git',
}
