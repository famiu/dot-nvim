local api = vim.api

local root_patterns = { '.git' }

-- Automatically change to project root directory using configured root patterns.
local function autocd()
    local bufname = api.nvim_buf_get_name(0)
    local path = vim.fs.dirname(bufname)

    local root_pattern_match = vim.fs.find(root_patterns, { path = path, stop = vim.uv.os_homedir(), upward = true })[1]

    if root_pattern_match == nil then
        return
    end

    vim.api.nvim_set_current_dir(vim.fs.dirname(root_pattern_match))
end

-- Automatically change current directory to LSP root directory on LSP attach.
local function lsp_autocd(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    assert(client ~= nil)

    if client.config.root_dir then
        vim.api.nvim_set_current_dir(client.config.root_dir)
    end
end

local augroup = api.nvim_create_augroup('AutoCD', {})

api.nvim_create_autocmd(
    { 'VimEnter', 'BufEnter', 'BufReadPost' },
    { group = augroup, callback = autocd, desc = 'Automatically change current directory by matching root pattern' }
)

api.nvim_create_autocmd(
    { 'LspAttach' },
    { group = augroup, callback = lsp_autocd, desc = 'Automatically change current directory to LSP root' }
)
