local start = vim.loop.hrtime()

require('settings')
require('keymaps')
require('daps')
require('plugins')
require('appearance')

-- -- show time it took to load
-- vim.api.nvim_create_autocmd("VimEnter", {
--     callback = function()
--         vim.defer_fn(function()
--             local elapsed_ms = (vim.loop.hrtime() - start) / 1e6
--             print(string.format("Neovim loaded in %.2f ms", elapsed_ms))
--         end, 0)
--     end,
-- })
