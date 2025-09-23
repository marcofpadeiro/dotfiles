require('theme')
require('settings')
require('keymaps')
require('lsp')
require('plugins.file_explorer')
require('plugins.treesitter')
require('plugins.telescope')
require('plugins.cmp')
require('plugins.harpoon')

-- show time it took to load
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local start = vim.loop.hrtime()
    vim.defer_fn(function()
      local elapsed_ms = (vim.loop.hrtime() - start) / 1e6
      print(string.format("Neovim loaded in %.2f ms", elapsed_ms))
    end, 0)
  end,
})

