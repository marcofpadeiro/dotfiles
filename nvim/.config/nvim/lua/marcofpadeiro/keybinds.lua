function CompileCode(param)
    vim.cmd(string.format('!tmux split-window -h /home/marco/dotfiles/scripts/compile.sh %s %s', param, vim.fn.getcwd()))
end

vim.keymap.set('n', '<leader>x', ':!chmod +x %<CR>')

vim.keymap.set('n', '<leader>c', ':w<CR>:lua CompileCode("compile")<CR><CR>')
vim.keymap.set('n', '<leader>v', ':lua CompileCode("edit")<CR><CR>')
vim.keymap.set('n', '<C-e>', ':!tmux new-window fzf-tmux<CR><CR>')

-- Fast saving
vim.keymap.set('n', "<leader>w", "<cmd>:w<CR>")

-- Undo Tree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

vim.keymap.set("n", "<leader>gi", vim.cmd.Neogit)

vim.keymap.set('v', "J", ":m '>+1<CR>gv=gv")
vim.keymap.set('v', "K", ":m '<-2<CR>gv=gv")

vim.keymap.set('v', ">", ">gv")
vim.keymap.set('v', "<", "<gv")

vim.keymap.set('n', "<leader>y", "\"+y")
vim.keymap.set('v', "<leader>y", "\"+y")
vim.keymap.set('n', "<leader>Y", "\"+Y")
vim.keymap.set('v', "<leader>p", "\"_dP")

-- Better buffer navigation
vim.keymap.set('n', "<S-l>", ":bnext<CR>")
vim.keymap.set('n', "<S-h>", ":bprevious<CR>")
