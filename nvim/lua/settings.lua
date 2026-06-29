vim.opt.guicursor = ""
vim.opt.wrap = false
vim.opt.scrolloff = 8

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.signcolumn = "yes"

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.undofile = true

vim.opt.foldenable = false

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.opt.laststatus = 0
vim.opt.ruler = true
vim.opt.winbar = "%f"

local languagesDiffIndent = { "javascript", "typescript", "typescriptreact", "json", "yaml", "html", "css", "lua", "vue",
  "cucumber" }

-- 2 spaces for web stuff
vim.api.nvim_create_autocmd("FileType", {
  pattern = languagesDiffIndent,
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

-- disable expensive features on large files
vim.api.nvim_create_autocmd("BufReadPre", {
  pattern = "*",
  callback = function(args)
    local max_filesize = 1024 * 1024 -- 1 MB
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
    if ok and stats and stats.size > max_filesize then
      vim.opt_local.swapfile = false
      vim.opt_local.undofile = false
      vim.b[args.buf].large_file = true
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function(args)
    if vim.b[args.buf].large_file then
      vim.schedule(function()
        vim.treesitter.stop(args.buf)
      end)
    end
  end,
})
