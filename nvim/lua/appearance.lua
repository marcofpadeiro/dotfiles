local icons = {
  [vim.diagnostic.severity.ERROR] = " ",
  [vim.diagnostic.severity.WARN]  = " ",
  [vim.diagnostic.severity.INFO]  = " ",
  [vim.diagnostic.severity.HINT]  = "󰌵 ",
  breakpoint                      = "",
  breakpoint_condition            = "",
  breakpoint_rejected             = "",
  breakpoint_stopped              = ""
}

-- diagnostic signs
vim.diagnostic.config({
  -- inline messages
  virtual_text = {
    spacing = 2,
    prefix = function(diagnostic)
      return icons[diagnostic.severity] or "● "
    end,
  },
  signs = false
})

-- breakpoint signs
vim.fn.sign_define("DapBreakpoint", { text = icons.breakpoint, texthl = "DapBreakpoint", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition",
  { text = icons.breakpoint_condition, texthl = "DapBreakpoint", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected",
  { text = icons.breakpoint_rejected, texthl = "DapBreakpointRejected", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped",
  { text = icons.breakpoint_stopped, texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "" })

-- breakpoint colorscheme
vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#e06c75" })
vim.api.nvim_set_hl(0, "DapBreakpointRejected", { fg = "#e06c75" })
vim.api.nvim_set_hl(0, "DapStopped", { fg = "#e06c75" })
vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#e06c75" })

-- highlight hex colors with the actual color
local ok, colorizer = pcall(require, 'colorizer')
if not ok then return end
colorizer.setup({
  user_default_options = {
    mode = "virtualtext"
  }
})

-- theme
vim.o.background = "dark"
vim.opt.termguicolors = true -- truecolor support
vim.cmd.colorscheme("gruvbox")
