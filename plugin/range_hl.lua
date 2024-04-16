--- Highlight command ranges
local augroup = vim.api.nvim_create_augroup('HighlightCommandRange', {})
local hl_ns = vim.api.nvim_create_namespace('HighlightCommandRange')

local function clear_highlights()
    vim.api.nvim_buf_clear_namespace(0, hl_ns, 0, -1)
end

vim.api.nvim_create_autocmd({ 'CmdlineEnter', 'CmdlineChanged' }, {
    desc = 'Highlight range of current command',
    group = augroup,
    callback = function()
        clear_highlights()

        local cmdline = vim.fn.getcmdline()
        local ok, parsed_cmdline = pcall(vim.api.nvim_parse_cmd, cmdline, {})

        if not ok then
            return
        end

        if parsed_cmdline.range == nil or vim.tbl_isempty(parsed_cmdline.range) then
            return
        end

        local line1 = parsed_cmdline.range[1]
        local line2 = parsed_cmdline.range[2] ~= nil and parsed_cmdline.range[2] or line1

        vim.highlight.range(0, hl_ns, 'Visual', { line1 - 1, 0 }, { line2 - 1, 0 }, { regtype = 'V' })
    end,
})

vim.api.nvim_create_autocmd('CmdlineLeave', {
    desc = 'Clear highlights after leaving cmdline',
    group = augroup,
    callback = clear_highlights,
})
