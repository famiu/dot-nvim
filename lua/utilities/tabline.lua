local api = vim.api
local fn = vim.fn
local M = {}

local close_icon = ''

--- Function used to switch buffer from tabline.
---
--- @param minwid integer
--- @param button string
function M.switch_buffer(minwid, _, button, _)
    if button == 'l' then
        vim.api.nvim_set_current_buf(minwid)
    end
end

--- Function used to switch delete from tabline.
---
--- @param minwid integer
--- @param button string
--- @param mods string
function M.delete_buffer(minwid, _, button, mods)
    if button == 'l' then
        local shift_pressed = mods:find('s') ~= nil
        require('bufdelete').bufdelete(minwid, shift_pressed)
    end
end

--- Create tabline component for a single buffer.
---
--- @param buf number
--- @param tp_nr? number
--- @return string
local function tabline_buf_component(buf, tp_nr)
    local bufname = api.nvim_buf_get_name(buf)
    local ok, devicons = pcall(require, 'nvim-web-devicons')
    local icon, hl, is_current_buf_or_tab

    if ok then
        icon = devicons.get_icon(bufname, fn.fnamemodify(bufname, ':e'), { default = true }) .. ' '
    else
        icon = ''
    end

    if bufname == '' then
        bufname = '[No Name]'
    else
        bufname = fn.fnamemodify(bufname, ':.') --[[ @as string ]]
    end

    if tp_nr ~= nil then
        local curr_tp_nr = api.nvim_tabpage_get_number(api.nvim_get_current_tabpage())
        is_current_buf_or_tab = tp_nr == curr_tp_nr
    else
        local current_buf = api.nvim_get_current_buf()
        is_current_buf_or_tab = buf == current_buf
    end

    if is_current_buf_or_tab then
        hl = 'TabLineSel'
    else
        hl = 'TabLine'
    end

    if tp_nr ~= nil then
        return string.format(
            [[%%#%s#%%%dT [%d] %s%s%%T%%%dX %s %%X]],
            hl, tp_nr, tp_nr, icon, bufname, tp_nr, close_icon
        )
    else
        return string.format(
            [[%%#%s#%%%d@v:lua.require'utilities.tabline'.switch_buffer@ %s%s%%T]] ..
            [[%%%d@v:lua.require'utilities.tabline'.delete_buffer@ %s %%X]],
            hl, buf, icon, bufname, buf, close_icon
        )
    end
end

--- Check if buffer is contained within the tab's current directory (or any of its subdirectories).
---
--- @param buf number
--- @return boolean
local function buf_in_current_directory(buf)
    local tab_cwd = vim.fn.getcwd(-1, 0) --[[ @as string ]]
    local filename = api.nvim_buf_get_name(buf)

    return vim.startswith(filename, tab_cwd)
end

--- Generate tabline tabline to use for the 'tabline' option.
--- The tabline contains a list of all tabs on the left, and a list of all buffers contained in the
--- current working directory of the current tab on the right.
---
--- @return string
function M.generate_tabline()
    local tp_elems = {}
    local buf_elems = {}

    for _, tp in ipairs(api.nvim_list_tabpages()) do
        local buf = api.nvim_win_get_buf(api.nvim_tabpage_get_win(tp))
        local tp_nr = api.nvim_tabpage_get_number(tp)

        tp_elems[#tp_elems+1] = tabline_buf_component(buf, tp_nr)
    end

    --- @type integer[]
    local buffers = vim.tbl_filter(function(buf)
        return api.nvim_buf_is_valid(buf) and api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted
            and buf_in_current_directory(buf)
    end, api.nvim_list_bufs())

    for _, buf in ipairs(buffers) do
        buf_elems[#buf_elems+1] = tabline_buf_component(buf)
    end

    return ('%s%%=%s%%#TabLineFill#'):format(table.concat(tp_elems), table.concat(buf_elems))
end

vim.o.tabline = [[%{%v:lua.require'utilities.tabline'.generate_tabline()%}]]
vim.o.showtabline = 2

return M
