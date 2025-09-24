local launch_cfg = function()
    return {
        type = "codelldb",
        request = "launch",
        name = "Debug",
        program = function()
            return vim.fn.input("Path to exe: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
    }
end

return {
    adapters = {
        codelldb = {
            type = "server",
            port = "${port}",
            executable = {
                command = "codelldb",
                args = { "--port", "${port}" },
            },
        },
    },
    configurations = {
        rust = { launch_cfg() },
        c    = { launch_cfg() },
        cpp  = { launch_cfg() },
    },
}
