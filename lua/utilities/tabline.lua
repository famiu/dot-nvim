local api = vim.api
local fn = vim.fn
local M = {}

local close_icon = ''

function M.generate_tabline()
    local curr_tp = api.nvim_get_current_tabpage()
    local tp_elems = {}

    for _, tp in ipairs(api.nvim_list_tabpages()) do
        local tp_number = api.nvim_tabpage_get_number(tp)
        local bufnr = api.nvim_win_get_buf(api.nvim_tabpage_get_win(tp))
        local bufname = api.nvim_buf_get_name(bufnr)
        local ok, devicons = pcall(require, 'nvim-web-devicons')
        local icon

        if ok then
            icon = devicons.get_icon(bufname, fn.fnamemodify(bufname, ':e'), { default = true }) .. ' '
        else
            icon = ''
        end

        if bufname == '' then
            bufname = '[No Name]'
        else
            bufname = fn.fnamemodify(bufname, ':.')
        end

        local hl
        if tp == curr_tp then
            hl = 'TabLineSel'
        else
            hl = 'TabLine'
        end

        tp_elems[#tp_elems + 1] = string.format(
            [[%%#%s#%%%dT [%d] %s%s%%T%%%dX %s %%X]],
            hl,
            tp_number,
            tp_number,
            icon,
            bufname,
            tp_number,
            close_icon
        )
    end

    return table.concat(tp_elems) .. [[%#TabLineFill#]] .. '  '
end

vim.o.tabline = [[%{%v:lua.require'utilities.tabline'.generate_tabline()%}]]

return M
