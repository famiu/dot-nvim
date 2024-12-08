-- Yank selection without leading indent.
function _G.my_yank_without_leading_indent(type)
    local tab_width = vim.o.tabstop
    local start_line, end_line

    if type == 'char' or type == 'line' then
        start_line, end_line = vim.fn.line("'["), vim.fn.line("']")
    else
        start_line, end_line = vim.fn.line("'<"), vim.fn.line("'>")
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

            if line_indent >= min_indent then
                -- Start by removing tabs, then remove spaces if more indentation needs to be removed.
                local tab_count = line:match('^[\t]*'):len()
                local tabs_to_remove = math.min(tab_count, math.ceil(min_indent / tab_width))
                line = line:sub(tabs_to_remove + 1)

                if tabs_to_remove * tab_width > min_indent then
                    -- Removing tabs removed more indentation than necessary, add spaces to compensate.
                    -- Make sure to add the spaces after the tabs.
                    local tabs = line:sub(1, line:match('^[\t]*'):len())
                    local spaces = string.rep(' ', tabs_to_remove * tab_width - min_indent)
                    line = tabs .. spaces .. line:sub(tabs:len() + 1)
                elseif tabs_to_remove * tab_width < min_indent then
                    -- Removing tabs did not remove enough indentation, remove spaces if there are any left.
                    local spaces_to_remove = math.min(line:match('^ *'):len(), min_indent - tabs_to_remove * tab_width)
                    line = line:sub(spaces_to_remove + 1)
                end

                lines[i] = line
            end
        end
    end

    local new_lines = table.concat(lines, '\n') .. '\n'
    vim.fn.setreg(vim.v.register, new_lines)

    -- Set yank marks
    vim.api.nvim_buf_set_mark(0, '[', start_line, 0, {})
    vim.api.nvim_buf_set_mark(0, ']', end_line, 0, {})

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

vim.keymap.set({ 'n', 'x' }, 'gy', function()
    vim.o.operatorfunc = 'v:lua.my_yank_without_leading_indent'
    return 'g@'
end, {
    desc = 'Yank selection without leading indent',
    expr = true,
    silent = true,
})

vim.keymap.set('n', 'gyy', function()
    vim.o.operatorfunc = 'v:lua.my_yank_without_leading_indent'
    return 'g@_'
end, {
    desc = 'Yank line without leading indent',
    expr = true,
    silent = true,
})
