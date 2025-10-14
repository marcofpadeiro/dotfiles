vim.opt.guicursor = ""        -- block cursor in all modes
vim.opt.wrap = false          -- no soft-wrap
vim.opt.scrolloff = 8         -- keep 8 lines visible around cursor

vim.opt.number = true         -- absolute line numbers
vim.opt.relativenumber = true -- relative numbers for movement

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.hlsearch = false -- no persistent highlight
vim.opt.incsearch = true -- highlight as you type

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.undofile = true

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99 -- keep folds open by default

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- 2 spaces for web stuff
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript", "lua", "vue", "json", "yaml", "html", "css" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

-- no comment on newline
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})
