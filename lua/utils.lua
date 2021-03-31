local M = {}
local cmd = vim.cmd
local types = {o = vim.o, b = vim.bo, w = vim.wo}

function M.set_opt(type, name, value)
    types[type][name] = value

    if type ~= 'o' then
        types['o'][name] = value
    end
end

function M.get_opt(type, name)
    return types[type][name]
end

function M.create_augroup(autocmds, name)
    cmd('augroup ' .. name)
    cmd('autocmd!')

    for _, autocmd in ipairs(autocmds) do
        cmd('autocmd ' .. table.concat(autocmd, ' '))
    end

    cmd('augroup END')
end

return M
