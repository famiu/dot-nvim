local api = vim.api
local lsp = vim.lsp

-- Automatically change to project root directory
local root_patterns = { '.git', 'Makefile', 'CMakeLists.txt' }

local function autocd()
    local clients = lsp.get_active_clients({ bufnr = 0 })

    for _, client in ipairs(clients) do
        if client.config.root_dir then
            vim.fn.chdir(client.config.root_dir)
            return
        end
    end

    local bufname = api.nvim_buf_get_name(0)

    if bufname == '' then
        return
    end

    local path = vim.fs.dirname(bufname)
    local root_pattern_match = vim.fs.find(root_patterns, { path = path, upward = true })[1]

    if root_pattern_match == nil then
        return
    end

    vim.fn.chdir(vim.fs.dirname(root_pattern_match))
end

local augroup = api.nvim_create_augroup('AutoCD', {})
api.nvim_create_autocmd(
    { 'VimEnter', 'BufEnter', 'BufReadPost', 'LspAttach' },
    { group = augroup, callback = autocd }
)
