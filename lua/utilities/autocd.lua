local api = vim.api
local lsp = vim.lsp
local fs = vim.fs

-- Automatically change to project root directory using either LSP or configured root patterns
local root_patterns = { '.git', 'Makefile', 'CMakeLists.txt' }

local function autocd()
    local clients = lsp.get_clients({ bufnr = 0 })

    for _, client in ipairs(clients) do
        if client.config.root_dir then
            pcall(api.nvim_set_current_dir, client.config.root_dir)
            return
        end
    end

    local bufname = api.nvim_buf_get_name(0)
    local path = fs.dirname(bufname)

    local root_pattern_match = fs.find(root_patterns, { path = path, upward = true })[1]

    if root_pattern_match == nil then
        return
    end

    pcall(vim.cmd.lcd, fs.dirname(root_pattern_match))
end

local augroup = api.nvim_create_augroup('AutoCD', {})
api.nvim_create_autocmd(
    { 'VimEnter', 'BufEnter', 'BufReadPost', 'LspAttach' },
    { group = augroup, callback = autocd, desc = 'Automatically change current directory' }
)
