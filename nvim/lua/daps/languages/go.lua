return {
    adapters = {
        go = {
            type = "server",
            host = "127.0.0.1",
            port = "${port}",
            executable = { command = "dlv", args = { "dap", "-l", "127.0.0.1:${port}" } }
        }
    },
    configurations = {
        go = {
            { type = "go", request = "launch", name = "Launch", program = "${file}" },
        }
    }
}
