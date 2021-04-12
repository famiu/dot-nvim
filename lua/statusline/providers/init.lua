local M = {}
local fn = vim.fn
local bo = vim.bo

local git = require('statusline.providers.git')
local lsp = require('statusline.providers.lsp')
local vi_mode = require('statusline.providers.vi_mode')

M.vi_mode = vi_mode.vi_mode

M.git_branch = git.git_branch
M.git_diff_added = git.git_diff_added
M.git_diff_removed = git.git_diff_removed
M.git_diff_changed = git.git_diff_changed

M.diagnostic_errors = lsp.diagnostic_errors
M.diagnostic_warnings = lsp.diagnostic_warnings
M.diagnostic_hints = lsp.diagnostic_hints
M.diagnostic_info = lsp.diagnostic_info

function M.file_info()
    local filename = fn.expand('%:t')
    local extension = fn.expand('%:e')
    local icon = require'nvim-web-devicons'.get_icon(filename, extension, { default = true })
    local modified

    if filename == '' then filename = 'unnamed' end

    if bo.modified then
        modified = '●' .. ' '
    else
        modified = ''
    end

    return ' ' .. icon .. ' ' .. filename .. ' ' .. modified
end

function M.file_size()
    local suffix = {'b', 'k', 'M', 'G', 'T', 'P', 'E'}
    local index = 1

    local fsize = fn.getfsize(fn.expand('%:p'))

    while fsize > 1024 and index < 7 do
        fsize = fsize / 1024
        index = index + 1
    end

    return string.format('%.2f', fsize) .. suffix[index]
end

function M.file_type()
    return bo[vim.api.nvim_get_current_buf()].filetype:upper()
end

function M.position()
    return string.format('%d:%d', fn.line('.'), fn.col('.'))
end

function M.diagnostics_error()

end

function M.line_percentage()
    local curr_line = fn.line('.')
    local lines = fn.line('$')

    if curr_line == 1 then
        return "Top"
    elseif curr_line == lines then
        return "Bot"
    else
        return fn.round(curr_line / lines * 100) .. '%%'
    end
end

function M.scroll_bar()
    local blocks =  {'▁', '▂', '▃', '▄', '▅', '▆', '▇', '█'}
    local width = 2

    local curr_line = fn.line('.')
    local lines = fn.line('$')

    local index = fn.floor(curr_line / lines * (#blocks - 1)) + 1

    return string.rep(blocks[index], width)
end

return M
