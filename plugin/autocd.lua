local root_patterns = { '.git' }
local augroup = vim.api.nvim_create_augroup('AutoCD', {})

vim.api.nvim_create_autocmd({ 'VimEnter', 'BufEnter', 'BufReadPost' }, {
    desc = 'Automatically change current directory by matching root pattern',
    group = augroup,
    callback = function(args)
        local root = vim.fs.root(vim.api.nvim_buf_get_name(args.buf), root_patterns)

        if root ~= nil then
            vim.api.nvim_set_current_dir(root)
        end
    end,
})

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'Automatically change current directory to LSP root',
    group = augroup,
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        assert(client ~= nil)

        if client.name ~= 'copilot' and client.config.root_dir then
            vim.api.nvim_set_current_dir(client.config.root_dir)
        end
    end,
})
