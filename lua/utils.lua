local M = {}
local api = vim.api
local keymap = vim.keymap

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
    local opts = { silent = true, buffer = 0 }

    keymap.set('n', 'k', 'gk', opts)
    keymap.set('n', 'j', 'gj', opts)
    keymap.set('n', '0', 'g0', opts)
    keymap.set('n', '^', 'g^', opts)
    keymap.set('n', '$', 'g$', opts)

    keymap.set('n', '<Up>', 'gk', opts)
    keymap.set('n', '<Down>', 'gj', opts)
    keymap.set('n', '<Home>', 'g<Home>', opts)
    keymap.set('n', '<End>', 'g<End>', opts)

    keymap.set('o', 'k', 'gk', opts)
    keymap.set('o', 'j', 'gj', opts)
    keymap.set('o', '0', 'g0', opts)
    keymap.set('o', '^', 'g^', opts)
    keymap.set('o', '$', 'g$', opts)

    keymap.set('o', '<Up>', 'gk', opts)
    keymap.set('o', '<Down>', 'gj', opts)
    keymap.set('o', '<Home>', 'g<Home>', opts)
    keymap.set('o', '<End>', 'g<End>', opts)

    keymap.set('i', '<Up>', '<C-o>gk', opts)
    keymap.set('i', '<Down>', '<C-o>gj', opts)
    keymap.set('i', '<Home>', '<C-o>g<Home>', opts)
    keymap.set('i', '<End>', '<C-o>g<End>', opts)
end

return M
