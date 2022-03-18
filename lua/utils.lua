local M = {}
local api = vim.api
local cmd = vim.cmd
local buf_bind = api.nvim_buf_set_keymap

-- Create an augroup
function M.create_augroup(autocmds, name, clear)
    local group = api.nvim_create_augroup(name, { clear = clear })

    for _, autocmd in ipairs(autocmds) do
        autocmd.opts.group = group
        api.nvim_create_autocmd(autocmd.event, autocmd.opts)
    end
end

-- Create a buffer-local augroup
function M.create_buf_augroup(bufnr, autocmds, name, clear)
    bufnr = bufnr or 0

    for _, autocmd in ipairs(autocmds) do
        autocmd.opts.buffer = bufnr
    end

    M.create_augroup(autocmds, name, clear)
end

-- Make navigation keys navigate through display lines instead of physical lines
function M.set_buffer_soft_line_navigation()
    local opts = { noremap = true, silent = true }

    buf_bind(0, 'n', 'k', 'gk', opts)
    buf_bind(0, 'n', 'j', 'gj', opts)
    buf_bind(0, 'n', '0', 'g0', opts)
    buf_bind(0, 'n', '^', 'g^', opts)
    buf_bind(0, 'n', '$', 'g$', opts)

    buf_bind(0, 'n', '<Up>', 'gk', opts)
    buf_bind(0, 'n', '<Down>', 'gj', opts)
    buf_bind(0, 'n', '<Home>', 'g<Home>', opts)
    buf_bind(0, 'n', '<End>', 'g<End>', opts)

    buf_bind(0, 'o', 'k', 'gk', opts)
    buf_bind(0, 'o', 'j', 'gj', opts)
    buf_bind(0, 'o', '0', 'g0', opts)
    buf_bind(0, 'o', '^', 'g^', opts)
    buf_bind(0, 'o', '$', 'g$', opts)

    buf_bind(0, 'o', '<Up>', 'gk', opts)
    buf_bind(0, 'o', '<Down>', 'gj', opts)
    buf_bind(0, 'o', '<Home>', 'g<Home>', opts)
    buf_bind(0, 'o', '<End>', 'g<End>', opts)

    buf_bind(0, 'i', '<Up>', '<C-o>gk', opts)
    buf_bind(0, 'i', '<Down>', '<C-o>gj', opts)
    buf_bind(0, 'i', '<Home>', '<C-o>g<Home>', opts)
    buf_bind(0, 'i', '<End>', '<C-o>g<End>', opts)
end

return M
