local api = vim.api
local fn = vim.fn

local function mkdir_on_save(opts)
    local path = vim.fs.dirname(api.nvim_buf_get_name(opts.buf))

    if fn.isdirectory(path) == 0 then
        fn.mkdir(path, 'p')
    end
end

-- Automatically create missing directories before save
api.nvim_create_autocmd('BufWritePre', { callback = mkdir_on_save, desc = 'Mkdir on save' })
