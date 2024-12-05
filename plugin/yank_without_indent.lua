-- Yank selection without leading indent.
local function yank_without_leading_indent()
    local tab_width = vim.o.tabstop

    local visual = vim.api.nvim_get_mode().mode:sub(1, 1):lower() == 'v'
    local start_line, end_line

    if visual then
        start_line, end_line = vim.fn.line('v'), vim.fn.line('.')

        if start_line > end_line then
            start_line, end_line = end_line, start_line
        end
    else
        start_line, end_line = vim.fn.line('.'), vim.fn.line('.')
    end

    -- NOTE: vim.fn.line() is 1-indexed, but vim.api.nvim_buf_get_lines() is 0-indexed and end-exclusive.
    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

    -- Nothing to yank, return early.
    if #lines == 0 then
        return
    end

    -- Find minimum leading whitespace.
    local min_indent = math.huge

    for lnum = start_line, end_line do
        -- Ignore empty lines
        if not lines[lnum - start_line + 1]:match('^%s*$') then
            local line_indent = vim.fn.indent(lnum)
            min_indent = math.min(min_indent, line_indent)

            -- Break early if no leading whitespace
            if min_indent == 0 then
                break
            end
        end
    end

    if min_indent ~= 0 then
        -- Remove leading whitespace from each line. Make sure to handle tabs correctly.
        for i, line in ipairs(lines) do
            local lnum = start_line + i - 1
            local line_indent = vim.fn.indent(lnum)

            -- Remove tabs if they are present, only remove spaces if all tabs are removed or if tab width is greater
            -- than the remaining indent width.
            if line_indent >= min_indent then
                local tab_count = line:match('^[\t]*'):len()
                local tabs_to_remove = math.min(tab_count, math.floor(min_indent / tab_width))
                line = line:sub(tabs_to_remove + 1)

                -- Remove spaces if there are any left.
                local spaces_to_remove = math.min(line:match('^ *'):len(), min_indent - tabs_to_remove * tab_width)
                lines[i] = line:sub(spaces_to_remove + 1)
            end
        end
    end

    local new_lines = table.concat(lines, '\n') .. '\n'
    vim.fn.setreg(vim.v.register, new_lines)

    -- Set yank marks
    vim.api.nvim_buf_set_mark(0, '[', start_line, 0, {})
    vim.api.nvim_buf_set_mark(0, ']', end_line, 0, {})

    if visual then
        -- Unselect the text
        vim.api.nvim_feedkeys(vim.keycode('<Esc>'), 'n', true)
        -- Jump to the beginning of the yanked text
        vim.api.nvim_feedkeys(vim.keycode('`['), 'n', true)
    end

    vim.api.nvim_exec_autocmds('TextYankPost', {
        modeline = false,
        data = {
            operator = 'y',
            regname = vim.v.register,
            regtype = vim.fn.getregtype(vim.v.register),
            regcontents = new_lines,
        },
    })
end

vim.keymap.set({ 'n', 'x' }, '<Leader>_y', yank_without_leading_indent, {
    silent = true,
    desc = 'Yank selection without leading indent',
})
