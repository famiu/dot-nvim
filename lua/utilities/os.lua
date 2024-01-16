local M = {}

-- Get processor unit count
M.pu_count = function()
    return #vim.uv.cpu_info()
end

M.is_linux = function()
    return vim.uv.os_uname().sysname == 'Linux'
end

M.is_macos = function()
    return vim.uv.os_uname().sysname == 'Darwin'
end

M.is_posix = function()
    return M.is_linux() or M.is_macos()
end

M.is_windows = function()
    return vim.uv.os_uname().sysname == 'Windows_NT'
end

return M
