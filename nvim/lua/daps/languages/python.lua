return {
  adapters = {
    python = {
      type = "executable",
      command = "python",
      args = { "-m", "debugpy.adapter" },
    },
  },
  configurations = {
    python = {
      {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        console = "integratedTerminal",
        cwd = "${workspaceFolder}",
      },
    },
  },
}
