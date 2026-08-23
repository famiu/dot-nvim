---@module 'auto-session'
---@type AutoSession.Config
local opts = {
    allowed_dirs = { vim.fs.joinpath(vim.uv.os_homedir(), 'Dev', '*') },
}

require('auto-session').setup(opts)
