local api = vim.api
local fn = vim.fn

local M = {}

--- @class MyTabLineConfig
--- @field close_icon string
M.config = { close_icon = '' }

--- Create tabline component for a single buffer.
---
--- @param buf integer
--- @param tp_nr integer
--- @return string
local function tabline_buf_component(buf, tp_nr)
    local bufname = api.nvim_buf_get_name(buf)
    local ok, devicons = pcall(require, 'nvim-web-devicons')
    local icon, hl, is_current_tab

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

    local curr_tp_nr = api.nvim_tabpage_get_number(api.nvim_get_current_tabpage())
    is_current_tab = tp_nr == curr_tp_nr

    if is_current_tab then
        hl = 'TabLineSel'
    else
        hl = 'TabLine'
    end

    return string.format(
        [[%%#%s#%%%dT [%d] %s%s%%T%%%dX %s %%X]],
        hl,
        tp_nr,
        tp_nr,
        icon,
        bufname,
        tp_nr,
        M.config.close_icon
    )
end

--- Generate tabline tabline to use for the 'tabline' option.
--- The tabline contains a list of all tabs on the left, and a list of all buffers contained in the
--- current working directory of the current tab on the right.
---
--- @return string
function M.generate_tabline()
    local tp_elems = {}

    for _, tp in ipairs(api.nvim_list_tabpages()) do
        local buf = api.nvim_win_get_buf(api.nvim_tabpage_get_win(tp))
        local tp_nr = api.nvim_tabpage_get_number(tp)

        table.insert(tp_elems, tabline_buf_component(buf, tp_nr))
    end

    return table.concat(tp_elems) .. '%#TabLineFill#'
end

vim.o.tabline = [[%{%v:lua.require'utilities.tabline'.generate_tabline()%}]]

return M
