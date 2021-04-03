local M = {}
local cmd = vim.cmd
local types = {o = vim.o, b = vim.bo, w = vim.wo}

-- Get table length
function M.length(table)
    local count = 0
    for _ in ipairs(table) do count = count + 1 end
    return count
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

return M
