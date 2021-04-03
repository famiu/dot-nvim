vim.g.startify_custom_header = 'startify#pad(startify#fortune#cowsay())'

-- Use Nvim-web-devicons for Startify
function _G.webDevIcons(path)
    local filename = vim.fn.fnamemodify(path, ':t')
    local extension = vim.fn.fnamemodify(path, ':e')
    return require'nvim-web-devicons'.get_icon(filename, extension, { default = true })
end

vim.api.nvim_exec([[
function! StartifyEntryFormat() abort
    return 'v:lua.webDevIcons(absolute_path) . " " . entry_path'
endfunction
]], false)
