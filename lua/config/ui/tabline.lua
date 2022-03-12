local api = vim.api
local fn = vim.fn
local opt = vim.opt
local devicons = require('nvim-web-devicons')

local M = {}

local file_modified_icon = '●'
local file_icon_default = ''
local tab_close_icon = ''

function M.tabline()
    local current_tp = api.nvim_get_current_tabpage()
    local tabline_sel_bg = string.format('%06x', api.nvim_get_hl_by_name('TabLineSel', {}).background)
    local tab_strs = {}

    for _, tp in ipairs(api.nvim_list_tabpages()) do
        local current = tp == current_tp
        local index = api.nvim_tabpage_get_number(tp)
        local win = api.nvim_tabpage_get_win(tp)
        local buf = api.nvim_win_get_buf(win)
        local filename = api.nvim_buf_get_name(buf)
        local extension = fn.fnamemodify(filename, ':e')
        local modified = api.nvim_buf_get_option(buf, 'modified')
        local file_icon, icon_fg = devicons.get_icon_color(filename, extension, { default = true })
        local display_filename
        local modified_str
        local tab_hl
        local icon_hl

        if filename == '' then
            display_filename = '[No Name]'
        else
            display_filename = fn.fnamemodify(filename, ':t')
        end

        if modified then
            modified_str = ' ' .. file_modified_icon
        else
            modified_str = ''
        end

        local icon_hlname = string.format(
            'TabLine_%s_%s_BOLD',
            string.sub(icon_fg, 2),
            tabline_sel_bg
        )

        vim.cmd(
            string.format(
                'highlight %s guifg=%s guibg=%s gui=bold',
                icon_hlname,
                icon_fg,
                tabline_sel_bg
            )
        )

        icon_hl = string.format('%%#%s#', icon_hlname)

        if current then
            tab_hl = icon_hl
        else
            tab_hl = '%*'
        end

        tab_strs[#tab_strs+1] = string.format(
            '%%%dT%s %d%s %s%s%s %s %%T%%%dX%s%%X %%*',
            index,
            tab_hl,
            index,
            modified_str,
            icon_hl,
            file_icon or file_icon_default,
            tab_hl,
            display_filename,
            index,
            tab_close_icon
        )
    end

    return table.concat(tab_strs)
end

opt.tabline = "%{%v:lua.require'config.ui.tabline'.tabline()%}"
opt.showtabline = 1

return M
