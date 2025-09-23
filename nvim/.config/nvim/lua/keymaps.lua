vim.keymap.set('n', '<leader>x', ':!chmod +x %<CR>')

vim.keymap.set('n', '<C-e>', ':!tmux new-window fzf-tmux<CR><CR>')

-- Fast saving
vim.keymap.set('n', "<leader>w", "<cmd>:lua vim.lsp.buf.format()<CR><cmd>:w<CR>")

vim.keymap.set('v', "J", ":m '>+1<CR>gv=gv")
vim.keymap.set('v', "K", ":m '<-2<CR>gv=gv")

vim.keymap.set('v', ">", ">gv")
vim.keymap.set('v', "<", "<gv")

vim.keymap.set('n', "<leader>y", "\"+y")
vim.keymap.set('v', "<leader>y", "\"+y")
vim.keymap.set('n', "<leader>Y", "\"+Y")
vim.keymap.set('v', "<leader>p", "\"_dP")

vim.keymap.set('v', "<leader>e", ":Oil")
