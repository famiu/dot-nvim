local api = vim.api

-- Trims all trailing whitespace in the current buffer
local function trim_space(opts)
    local buf = api.nvim_get_current_buf()
    local lines = api.nvim_buf_get_lines(buf, opts.line1 - 1, opts.line2, false)
    local new_lines = {}

    for i, line in ipairs(lines) do
        new_lines[i] = string.gsub(line, '%s+$', '')
    end

    api.nvim_buf_set_lines(buf, opts.line1 - 1, opts.line2, false, new_lines)
end

-- Preview function for trim_space
local function trim_space_preview(opts, preview_ns, _)
    local buf = api.nvim_get_current_buf()
    local lines = api.nvim_buf_get_lines(buf, opts.line1 - 1, opts.line2, false)

    for i, line in ipairs(lines) do
        local start_idx, end_idx = string.find(line, '%s+$')

        if start_idx then
            -- Highlight the match
            api.nvim_buf_add_highlight(
                buf,
                preview_ns,
                'Substitute',
                opts.line1 + i - 2,
                start_idx - 1,
                end_idx
            )
        end
    end

    return 1
end

api.nvim_create_user_command(
    'TrimSpace',
    trim_space,
    { nargs = 0, range = '%', addr = 'lines', preview = trim_space_preview }
)

vim.keymap.set('n', '<Leader>t<Space>', '<CMD>TrimSpace<CR>', {})
