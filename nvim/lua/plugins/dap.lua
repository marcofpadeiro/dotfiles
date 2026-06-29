return {
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        config = function()
          local dap = require("dap")
          local dap_ui = require("dapui")
          dap_ui.setup()

          dap.listeners.before.attach.dapui_config = function() dap_ui.open() end
          dap.listeners.before.launch.dapui_config = function() dap_ui.open() end
          dap.listeners.before.event_terminated.dapui_config = function() dap_ui.close() end
          dap.listeners.before.event_exited.dapui_config = function() dap_ui.close() end
        end,
      },
      { "theHamsta/nvim-dap-virtual-text", config = true },
    },
    config = function()
      local dap = require("dap")

      -- Force terminal to open in a bottom split instead of taking over the main window
      dap.defaults.fallback.force_external_terminal = false
      dap.defaults.fallback.terminal_win_cmd = "belowright 12new"

      -- Keymaps
      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "DAP continue" })
      vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "DAP step into" })
      vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "DAP step over" })
      vim.keymap.set("n", "<leader>du", dap.step_out, { desc = "DAP step out" })
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP toggle breakpoint" })
      vim.keymap.set("n", "<leader>dB", function() dap.set_breakpoint(vim.fn.input("Condition: ")) end, { desc = "DAP conditional breakpoint" })
      vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "DAP restart" })
      vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "DAP terminate" })
      vim.keymap.set("n", "<leader>de", function() require("dapui").eval(nil, { enter = true }) end, { desc = "DAP eval" })
      vim.keymap.set("n", "<leader>dg", dap.run_to_cursor, { desc = "DAP run to cursor" })
      vim.keymap.set("n", "<leader>dq", function()
        dap.terminate()
        require("dapui").close()
      end, { desc = "DAP quit and close UI" })

      -- Go
      dap.adapters.go = {
        type = "server",
        host = "127.0.0.1",
        port = "${port}",
        executable = { command = "dlv", args = { "dap", "-l", "127.0.0.1:${port}" } },
      }
      dap.configurations.go = {
        { type = "go", request = "launch", name = "Launch", program = "${file}" },
      }

      -- Python
      dap.adapters.python = {
        type = "executable",
        command = "python",
        args = { "-m", "debugpy.adapter" },
      }
      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          console = "internalConsole",
          cwd = "${workspaceFolder}",
        },
      }

      -- Rust / C / C++
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = "codelldb",
          args = { "--port", "${port}" },
        },
      }
      local codelldb_cfg = {
        type = "codelldb",
        request = "launch",
        name = "Debug",
        program = function()
          return vim.fn.input("Path to exe: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      }
      dap.configurations.rust = { codelldb_cfg }
      dap.configurations.c = { codelldb_cfg }
      dap.configurations.cpp = { codelldb_cfg }

      -- JavaScript
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "127.0.0.1",
        port = "${port}",
        executable = { command = "dlv", args = { "dap", "-l", "127.0.0.1:${port}" } },
      }
      dap.configurations.javascript = {
        { type = "pwa-node", request = "launch", name = "Launch file", program = "${file}", cwd = "${workspaceFolder}" },
      }

      -- Lua
      dap.adapters.nlua = function(cb, config)
        cb({
          type = "server",
          host = config.host or "127.0.0.1",
          port = config.port or 8086,
        })
      end
      dap.configurations.lua = {
        {
          type = "nlua",
          request = "attach",
          name = "Attach to running Neovim",
          host = function() return "127.0.0.1" end,
          port = function() return 8086 end,
        },
      }
    end,
  },
}
