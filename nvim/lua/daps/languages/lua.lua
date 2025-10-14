return {
  adapters = {
    nlua = function(cb, config)
      cb({
        type = "server",
        host = config.host or "127.0.0.1",
        port = config.port or 8086,
      })
    end,
  },
  configurations = {
    lua = {
      {
        type = "nlua",
        request = "attach",
        name = "Attach to running Neovim",
        host = function() return "127.0.0.1" end,
        port = function() return 8086 end,
      },
    },
  },
}
