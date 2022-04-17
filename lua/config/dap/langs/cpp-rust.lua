local dap = require('dap')
local last_gdb_config

dap.adapters.cpp = {
    type = 'executable',
    attach = {
        pidProperty = "pid",
        pidSelect = "ask"
    },
    command = 'lldb-vscode',
    env = {
        LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"
    },
    name = "lldb"
}

local function start_c_debugger(args, mi_mode, mi_debugger_path)
    if args and #args > 0 then
        last_gdb_config = {
            type = "cpp",
            name = args[1],
            request = "launch",
            program = table.remove(args, 1),
            args = args,
            cwd = vim.fn.getcwd(),
            -- Environment variables are set via `ENV_VAR_NAME=value` pairs
            env = {},
            externalConsole = true,
            MIMode = mi_mode or "gdb",
            MIDebuggerPath = mi_debugger_path
        }
    end

    if not last_gdb_config then
        print('No binary to debug set! Use ":DebugC <binary> <args>" or ":DebugRust <binary> <args>"')
        return
    end

    dap.run(last_gdb_config)
    dap.repl.open()
end

local function DebugC(opts)
    local args = opts.fargs
    args[#args+1] = 'gdb'
    start_c_debugger(args)
end

local function DebugRust(opts)
    local args = opts.fargs
    args[#args+1] = 'gdb'
    args[#args+1] = 'rust-gdb'
    start_c_debugger(args)
end

vim.api.nvim_create_user_command('DebugC', DebugC, { complete = 'file', nargs = '*' })
vim.api.nvim_create_user_command('DebugRust', DebugRust, { complete = 'file', nargs = '*' })
