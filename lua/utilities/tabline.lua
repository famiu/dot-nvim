local api = vim.api
local fn = vim.fn
local M = {}

local last_buffers_list = {}
local close_icon = ''

--- Function used to switch buffer from tabline.
---
--- @param minwid integer
--- @param button string
function M.switch_buffer(minwid, _, button, _)
    if button == 'l' then
        api.nvim_set_current_buf(minwid)
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

--- Go to n-th buffer after current one as shown in the tabline's buffer list.
--- n can be negative to indicate previous buffer.
--- This wraps around the buffer list if it reaches the beginning or end of the buffer list.
---
--- @param n integer
function M.tabline_buffer_advance(n)
    local current_buffer = api.nvim_get_current_buf()
    local buffer_count = #last_buffers_list
    -- Index of the current buffer in last_buffers_list
    local current_buffer_idx

    for i, v in ipairs(last_buffers_list) do
        if v == current_buffer then
            current_buffer_idx = i
            break
        end
    end

    if current_buffer_idx == nil then
        error('Tabline: Cannot find current buffer in buffer list')
    end

    -- Add n to the current buffer's index and wrap around the range [1, buffer_count] to get the
    -- index of the buffer to switch to.
    local target_buffer_idx = (current_buffer_idx + n - 1) % buffer_count + 1
    api.nvim_set_current_buf(last_buffers_list[target_buffer_idx])
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
    local tab_cwd = vim.fn.getcwd(-1, 0) .. '/'
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
    last_buffers_list = vim.tbl_filter(function(buf)
        return api.nvim_buf_is_valid(buf) and api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted
            and buf_in_current_directory(buf)
    end, api.nvim_list_bufs())

    for _, buf in ipairs(last_buffers_list) do
        buf_elems[#buf_elems+1] = tabline_buf_component(buf)
    end

    return ('%s%%=%s%%#TabLineFill#'):format(table.concat(tp_elems), table.concat(buf_elems))
end

vim.o.tabline = [[%{%v:lua.require'utilities.tabline'.generate_tabline()%}]]
vim.o.showtabline = 2

return M
