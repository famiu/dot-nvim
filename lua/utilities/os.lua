return {
    pu_count = function() return #vim.uv.cpu_info() end,
    is_linux = function() return vim.uv.os_uname().sysname == 'Linux' end,
    is_macos = function() return vim.uv.os_uname().sysname == 'Darwin' end,
    is_windows = function() return vim.uv.os_uname().sysname == 'Windows_NT' end,
}
