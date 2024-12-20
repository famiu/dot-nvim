local function to_buffer_complete(arg_lead, cmd_line, cursor_pos)
    local to_buffer_pos, wrapped_command_pos = cmd_line:find('ToBuffer%s+')

    if not to_buffer_pos then
        return {}
    end

    local wrapped_command = cmd_line:sub(wrapped_command_pos + 1, cursor_pos)
    local command_name_end = wrapped_command:find('%s') or math.huge

    if wrapped_command == '' or cursor_pos <= command_name_end then
        -- If no command yet, complete available Ex commands.
        return vim.fn.getcompletion(arg_lead, 'command')
    else
        -- If a command is present, complete its arguments.
        return vim.fn.getcompletion(wrapped_command, 'cmdline')
    end
end

--- @param args vim.api.keyset.create_user_command.command_args
local function to_buffer(args)
    local command = table.concat(args.fargs, ' ')

    -- Execute the provided command and capture its output.
    local ok, result = pcall(vim.api.nvim_exec2, command, { output = true })
    if not ok then
        vim.notify('Error executing command: ' .. command .. '\n' .. result, 'error')
        return
    end

    -- Create a new scratch buffer and populate it with the command output.
    local buf = vim.api.nvim_create_buf(false, true) -- Create a scratch buffer
    vim.api.nvim_set_option_value('bufhidden', 'wipe', { buf = buf }) -- Buffer disappears when unloaded
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(result.output, '\n')) -- Set buffer lines

    -- Open the buffer in a new window.
    vim.api.nvim_cmd({ cmd = 'new', mods = args.smods }, {})
    vim.api.nvim_set_current_buf(buf)
end

-- `:ToBuffer` command.
-- Execute a command and display its output in a new buffer.
vim.api.nvim_create_user_command('ToBuffer', to_buffer, {
    nargs = '+',
    complete = to_buffer_complete,
    force = true,
})

-- `:Messages` command.
-- Display messages in a new buffer.
-- Uses `:ToBuffer messages` internally.
vim.api.nvim_create_user_command('Messages', function()
    vim.api.nvim_command('ToBuffer messages')
end, {
    desc = 'Display messages in a new buffer',
})
