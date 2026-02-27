local ok, harpoon = pcall(require, 'harpoon')
if not ok then return end

harpoon:setup()

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>m", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>n", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>e", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>i", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>o", function() harpoon:list():select(4) end)
