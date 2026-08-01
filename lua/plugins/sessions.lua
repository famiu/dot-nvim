return {
    'rmagatti/auto-session',
    lazy = false,

    ---@module 'auto-session'
    ---@type AutoSession.Config
    opts = {
        allowed_dirs = { vim.fs.joinpath(vim.uv.os_homedir(), 'Dev', '*') },
    },
}
