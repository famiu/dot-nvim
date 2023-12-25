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
    before_init = require('neodev.lsp').before_init,
    settings = {
        Lua = {
            workspace = {
                checkThirdParty = false
            }
        }
    }
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
