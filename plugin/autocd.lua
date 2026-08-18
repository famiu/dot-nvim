local root_patterns = { '.git' }
local augroup = vim.api.nvim_create_augroup('AutoCD', {})
local ignored_clients = {
    copilot = true,
}

local function client_root(client)
    if ignored_clients[client.name] then
        return nil
    end

    return client.root_dir
end

local function set_root(bufnr, root)
    if root and root ~= vim.fn.getcwd(-1, -1, bufnr) then
        vim.api.nvim_buf_call(bufnr, function()
            vim.cmd.bcd(root)
        end)
    end
end

local function lsp_root(bufnr)
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
        local root = client_root(client)
        if root then return root end
    end
    return nil
end

vim.api.nvim_create_autocmd({ 'VimEnter', 'BufEnter' }, {
    desc = 'Automatically change current directory by matching root pattern',
    group = augroup,
    callback = function(args)
        -- Buffer may no longer be valid when this callback is triggered.
        if vim.api.nvim_buf_is_valid(args.buf) == false then return end

        if vim.bo[args.buf].buftype ~= '' then return end

        local name = vim.api.nvim_buf_get_name(args.buf)
        if name == '' then return end

        set_root(args.buf, lsp_root(args.buf) or vim.fs.root(name, root_patterns))
    end,
})

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'Automatically change current directory to LSP root',
    group = augroup,
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        set_root(args.buf, client_root(client))
    end,
})
