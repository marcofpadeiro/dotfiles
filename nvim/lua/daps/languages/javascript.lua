return {
  adapters = {
    ["pwa-node"] = {
      type = "server",
      host = "127.0.0.1",
      port = "${port}",
      executable = { command = "dlv", args = { "dap", "-l", "127.0.0.1:${port}" } }
    }
  },
  configurations = {
    javascript = {
      { type = "pwa-node", request = "launch", name = "Launch file", program = "${file}", cwd = "${workspaceFolder}" },
    }
  }

}
