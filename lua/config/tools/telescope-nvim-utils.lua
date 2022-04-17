local keymap = vim.keymap

local M = {}

-- Function to bind picker to key combination
function M.bind_picker(keys, picker_name, extension_name)
    if extension_name ~= nil then
        keymap.set(
            'n', keys,
            "<cmd>lua require('telescope').extensions['" .. extension_name .. "']"
            .. "['" .. picker_name .. "']" .. "()<CR>",
            {}
        )
    else
        keymap.set(
            'n', keys,
            "<cmd>lua require('telescope.builtin')['" .. picker_name .. "']" .. "()<CR>",
            {}
        )
    end
end

function M.buf_bind_picker(bufnr, keys, picker_name, extension_name)
    if extension_name ~= nil then
        keymap.set(
            'n', keys,
            "<cmd>lua require('telescope').extensions['" .. extension_name .. "']"
            .. "['" .. picker_name .. "']" .. "()<CR>",
            { buffer = bufnr }
        )
    else
        keymap.set(
            'n', keys,
            "<cmd>lua require('telescope.builtin')['" .. picker_name .. "']" .. "()<CR>",
            { buffer = bufnr }
        )
    end
end

return M
