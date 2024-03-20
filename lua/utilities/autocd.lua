local api = vim.api
local fs = vim.fs

-- Automatically change to project root directory using either LSP or configured root patterns
local root_patterns = { '.git', 'Makefile', 'CMakeLists.txt' }

local function autocd()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    local target_dir

    for _, client in ipairs(clients) do
        -- Ignore copilot as it doesn't have a valid root directory.
        if client.name ~= 'copilot' and client.config.root_dir then
            target_dir = client.config.root_dir
            break
        end
    end

    if target_dir == nil then
        local bufname = api.nvim_buf_get_name(0)
        local path = fs.dirname(bufname)

        local root_pattern_match = fs.find(root_patterns, { path = path, upward = true })[1]

        if root_pattern_match == nil then
            return
        end

        target_dir = fs.dirname(root_pattern_match)
    end

    pcall(api.nvim_set_current_dir, target_dir)
end

local augroup = api.nvim_create_augroup('AutoCD', {})
api.nvim_create_autocmd(
    { 'VimEnter', 'BufEnter', 'BufReadPost', 'LspAttach' },
    { group = augroup, callback = autocd, desc = 'Automatically change current directory' }
)
