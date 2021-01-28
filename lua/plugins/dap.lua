local dap = require 'dap'

dap.adapters.cpp = {
    type = 'executable',
    command = 'lldb-vscode',
    env = {
        LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = 'YES',
    },
    name = 'lldb',
    attach = {
        pidProperty = 'pid',
        pidSelect = 'ask',
    }
}

dap.defaults.fallback.external_terminal = {
    command = '/usr/bin/kitty',
    args = {'-e'},
}

local M = {}
local last_gdb_config

function M.start_c_debugger(args) 
    if args and #args > 0 then
        last_gdb_config = {
            type = 'cpp',
            name = args[1],
            request = 'launch',
            program = table.remove(args, 1),
            args = args,
            cwd = vim.fn.getcwd(),
            console = 'externalTerminal',
            stopOnEntry = true,
        }
    end

    if not last_gdb_config then
        print('No binary to debug set!')
        return
    end

    dap.run(last_gdb_config)
    dap.repl.open()
end

return M
