-- Status column configuration to separate gitsigns from diagnostics
local M = {}

local function get_signs()
    local buf = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
    return vim.tbl_map(function(sign)
        return vim.fn.sign_getdefined(sign.name)[1]
    end, vim.fn.sign_getplaced(buf, { group = '*', lnum = vim.v.lnum })[1].signs)
end

function M.statuscolumn()
    local sign, git_sign

    for _, s in ipairs(get_signs()) do
        if s.name:find('GitSign') then
            git_sign = s
        else
            sign = s
        end
    end

    if sign and not sign.texthl then vim.g.testvar = sign end

    local components = {
        sign and ((sign.texthl and ('%#' .. sign.texthl .. '#') or '') .. sign.text .. '%*') or ' ',
        [[%=]],
        [[%{&nu ? (&rnu && v:relnum ? v:relnum : v:lnum) : ''} ]],
        git_sign and ('%#' .. git_sign.texthl .. '#' .. git_sign.text .. '%*') or '  ',
    }
    return table.concat(components)
end

vim.o.signcolumn = 'yes'
vim.o.statuscolumn = [[%!v:lua.require'utilities.statuscolumn'.statuscolumn()]]

return M
