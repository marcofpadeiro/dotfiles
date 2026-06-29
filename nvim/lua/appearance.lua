local icons = {
  [vim.diagnostic.severity.ERROR] = " ",
  [vim.diagnostic.severity.WARN]  = " ",
  [vim.diagnostic.severity.INFO]  = " ",
  [vim.diagnostic.severity.HINT]  = "󰌵 ",
  breakpoint                      = "●",
  breakpoint_condition            = "◆",
  breakpoint_rejected             = "✗",
  breakpoint_stopped              = "▶"
}

-- diagnostic signs
vim.diagnostic.config({
  virtual_text = {
    spacing = 2,
    prefix = function(diagnostic)
      return icons[diagnostic.severity] or "● "
    end,
  },
  signs = false
})

-- breakpoint signs (Neovim 0.12+ uses highlight-based signs)
local dap_signs = {
  DapBreakpoint = { text = icons.breakpoint, texthl = "DapBreakpoint" },
  DapBreakpointCondition = { text = icons.breakpoint_condition, texthl = "DapBreakpoint" },
  DapBreakpointRejected = { text = icons.breakpoint_rejected, texthl = "DapBreakpointRejected" },
  DapStopped = { text = icons.breakpoint_stopped, texthl = "DapStopped", linehl = "DapStoppedLine" },
}

for name, sign in pairs(dap_signs) do
  vim.fn.sign_define(name, sign)
end

-- breakpoint colorscheme
vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#e06c75" })
vim.api.nvim_set_hl(0, "DapBreakpointRejected", { fg = "#e06c75" })
vim.api.nvim_set_hl(0, "DapStopped", { fg = "#e06c75" })
vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#e06c75" })

-- theme
vim.o.background = "dark"
vim.opt.termguicolors = true
vim.cmd.colorscheme("kanagawa")
