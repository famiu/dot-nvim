local M = {}
local cmd = vim.cmd
local types = {o = vim.o, b = vim.bo, w = vim.wo}
local buf_bind = vim.api.nvim_buf_set_keymap

-- Check if list contains element
function M.contains(list, elem)
    for _, v in pairs(list) do
        if v == elem then
            return true
        end
    end

    return false
end

-- Get option
function M.get_opt(type, name)
    return types[type][name]
end

-- Set option
function M.set_opt(type, name, value)
    types[type][name] = value

    if type ~= 'o' then
        types['o'][name] = value
    end
end

-- Append option to a list of options
function M.append_opt(type, name, value)
    local current_value = M.get_opt(type, name)

    if not string.match(current_value, value) then
        M.set_opt(type, name, current_value .. value)
    end
end

-- Remove option from a list of options
function M.remove_opt(type, name, value)
    local current_value = M.get_opt(type, name)

    if string.match(current_value, value) then
        M.set_opt(type, name, string.gsub(current_value, value, ""))
    end
end

-- Create an augroup
function M.create_augroup(autocmds, name)
    cmd('augroup ' .. name)
    cmd('autocmd!')

    for _, autocmd in ipairs(autocmds) do
        cmd('autocmd ' .. table.concat(autocmd, ' '))
    end

    cmd('augroup END')
end

-- Create a buffer-local augroup
function M.create_buf_augroup(autocmds, name)
    cmd('augroup ' .. name)
    cmd('autocmd!' .. ' * <buffer>')

    for _, autocmd in ipairs(autocmds) do
        cmd('autocmd ' .. table.concat(autocmd, ' '))
    end

    cmd('augroup END')
end

-- Make navigation keys navigate through display lines instead of physical lines
function M.set_buffer_soft_line_nagivation()
    local opts = { noremap = true, silent = true }

    buf_bind(0, 'n', 'k', 'gk', opts)
    buf_bind(0, 'n', 'j', 'gj', opts)
    buf_bind(0, 'n', '0', 'g0', opts)
    buf_bind(0, 'n', '^', 'g^', opts)
    buf_bind(0, 'n', '$', 'g$', opts)

    buf_bind(0, 'n', '<Up>', 'gk', opts)
    buf_bind(0, 'n', '<Down>', 'gj', opts)
    buf_bind(0, 'n', '<Home>', 'g<Home>', opts)
    buf_bind(0, 'n', '<End>', 'g<End>', opts)

    buf_bind(0, 'o', 'k', 'gk', opts)
    buf_bind(0, 'o', 'j', 'gj', opts)
    buf_bind(0, 'o', '0', 'g0', opts)
    buf_bind(0, 'o', '^', 'g^', opts)
    buf_bind(0, 'o', '$', 'g$', opts)

    buf_bind(0, 'o', '<Up>', 'gk', opts)
    buf_bind(0, 'o', '<Down>', 'gj', opts)
    buf_bind(0, 'o', '<Home>', 'g<Home>', opts)
    buf_bind(0, 'o', '<End>', 'g<End>', opts)

    buf_bind(0, 'i', '<Up>', '<C-o>gk', opts)
    buf_bind(0, 'i', '<Down>', '<C-o>gj', opts)
    buf_bind(0, 'i', '<Home>', '<C-o>g<Home>', opts)
    buf_bind(0, 'i', '<End>', '<C-o>g<End>', opts)
end

return M
