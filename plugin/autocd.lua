local root_patterns = { '.git' }
local augroup = vim.api.nvim_create_augroup('AutoCD', {})

local function set_root(root)
    if root and root ~= vim.fn.getcwd(0) then
        vim.cmd.tcd(root)
    end
end

local function lsp_root(bufnr)
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
        if client.name ~= 'copilot' and client.config.root_dir then
            return client.config.root_dir
        end
    end
    return nil
end

vim.api.nvim_create_autocmd({ 'VimEnter', 'BufEnter' }, {
    desc = 'Automatically change current directory by matching root pattern',
    group = augroup,
    callback = function(args)
        if vim.bo[args.buf].buftype ~= '' then return end

        local name = vim.api.nvim_buf_get_name(args.buf)
        if name == '' then return end

        set_root(lsp_root(args.buf) or vim.fs.root(name, root_patterns))
    end,
})

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'Automatically change current directory to LSP root',
    group = augroup,
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        if client.name ~= 'copilot' then
            set_root(client.config.root_dir)
        end
    end,
})
