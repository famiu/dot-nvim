local themes = require('telescope.themes')
local keymap = vim.keymap

local M = {}

local function get_theme(name)
    if name == nil then
        return nil
    elseif name == 'ivy' then
        return themes.get_ivy()
    elseif name == 'dropdown' then
        return themes.get_dropdown()
    elseif name == 'cursor' then
        return themes.get_cursor()
    else
        return nil
    end
end

-- Function to bind picker to key combination
function M.bind_picker(keys, picker_name, extension_name, theme)
    if extension_name ~= nil then
        keymap.set(
            'n', keys,
            function ()
                require('telescope').extensions[extension_name][picker_name](get_theme(theme))
            end,
            {}
        )
    else
        keymap.set(
            'n', keys,
            function ()
                require('telescope.builtin')[picker_name](get_theme(theme))
            end,
            {}
        )
    end
end

function M.buf_bind_picker(bufnr, keys, picker_name, extension_name, theme)
    if extension_name ~= nil then
        keymap.set(
            'n', keys,
            function ()
                require('telescope').extensions[extension_name][picker_name](get_theme(theme))
            end,
            { buffer = bufnr }
        )
    else
        keymap.set(
            'n', keys,
            function ()
                require('telescope.builtin')[picker_name](get_theme(theme))
            end,
            { buffer = bufnr }
        )
    end
end

return M
