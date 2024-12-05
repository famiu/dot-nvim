--- Highlight command ranges
local augroup = vim.api.nvim_create_augroup('HighlightCommandRange', {})
local hl_ns = vim.api.nvim_create_namespace('HighlightCommandRange')
local timer --- @type uv.uv_timer_t|nil

local function destroy_timer()
    if timer ~= nil and timer:has_ref() then
        timer:stop()
        if not timer:is_closing() then
            timer:close()
        end
    end

    timer = nil
end

--- @param buf integer
--- @param range integer[]
local function highlight_range(buf, range)
    local line1 = range[1]
    local line2 = range[2] ~= nil and range[2] or line1

    if vim.api.nvim_buf_is_loaded(buf) then
        vim.hl.range(buf, hl_ns, 'Visual', { line1 - 1, 0 }, { line2 - 1, 0 }, { regtype = 'V' })
    end
end

--- @param buf integer
local function clear_highlights(buf)
    destroy_timer()

    if vim.api.nvim_buf_is_loaded(buf) then
        vim.api.nvim_buf_clear_namespace(buf, hl_ns, 0, -1)
    end
end

vim.api.nvim_create_autocmd('CmdlineChanged', {
    desc = 'Highlight range of current command',
    group = augroup,
    callback = function(args)
        if vim.v.event.cmdtype ~= ':' then
            return
        end

        local cmdline = vim.fn.getcmdline()
        local ok, parsed_cmdline = pcall(vim.api.nvim_parse_cmd, cmdline, {})

        if not ok or parsed_cmdline.range == nil or vim.tbl_isempty(parsed_cmdline.range) then
            clear_highlights(args.buf)
            return
        end

        if timer ~= nil then
            timer:again()
        else
            timer = vim.uv.new_timer()
            assert(timer ~= nil)

            timer:start(
                50,
                0,
                vim.schedule_wrap(function()
                    clear_highlights(args.buf)
                    highlight_range(args.buf, parsed_cmdline.range)
                end)
            )
        end
    end,
})

vim.api.nvim_create_autocmd('CmdlineLeave', {
    desc = 'Clear highlights after leaving cmdline',
    group = augroup,
    callback = function(args)
        clear_highlights(args.buf)
    end,
})
