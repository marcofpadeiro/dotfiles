local status_ok = pcall(require, "telescope")
if not status_ok then
    return
end

local builtin = require('telescope.builtin')

function Cht_current_file()
    local filetype = vim.bo.filetype
    vim.cmd(string.format('!tmux split-window -h cht %s', filetype))
end

function CompileCode(param)
    vim.cmd(string.format('!tmux split-window -h /home/marco/dotfiles/scripts/compile.sh %s %s', param, vim.fn.getcwd()))
end

vim.keymap.set('n', '<leader>md', ':MarkdownPreviewToggle<CR>')
vim.keymap.set('n', '<leader>x', ':!chmod +x %<CR>')

vim.keymap.set('n', '<C-S-i>', ':!tmux split-window -h cht<CR><CR>')
vim.keymap.set('n', '<C-i>', ':lua Cht_current_file()<CR><CR>')
vim.keymap.set('n', '<leader>c', ':lua CompileCode("compile")<CR><CR>')
vim.keymap.set('n', '<leader>v', ':lua CompileCode("edit")<CR><CR>')
vim.keymap.set('n', '<C-e>', ':!tmux new-window fzf-tmux<CR><CR>')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.keymap.set('n', '<leader>t', vim.diagnostic.open_float)
vim.keymap.set('i', '<C-j>', '<cmd>lua require("cmp").select_next_item()<CR>')
vim.keymap.set('i', '<C-k>', '<cmd>lua require("cmp").select_prev_item()<CR>')
vim.keymap.set('i', '<C-a>', '<cmd>lua require("cmp").complete()<CR>')

-- Fast saving
vim.keymap.set('n', "<leader>w", "<cmd>:lua vim.lsp.buf.format()<CR>:w<CR>")

-- Undo Tree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- Harpoon
vim.keymap.set('n', "<leader>h", ':lua require("harpoon.ui").nav_file(1)<CR>')
vim.keymap.set('n', "<leader>j", ':lua require("harpoon.ui").nav_file(2)<CR>')
vim.keymap.set('n', "<leader>k", ':lua require("harpoon.ui").nav_file(3)<CR>')
vim.keymap.set('n', "<leader>l", ':lua require("harpoon.ui").nav_file(4)<CR>')
vim.keymap.set('n', "<leader>m", ':lua require("harpoon.ui").toggle_quick_menu()<CR>')
vim.keymap.set('n', "<leader>a", ':lua require("harpoon.mark").add_file()<CR>')

vim.keymap.set('v', "J", ":m '>+1<CR>gv=gv")
vim.keymap.set('v', "K", ":m '<-2<CR>gv=gv")

vim.keymap.set('v', ">", ">gv")
vim.keymap.set('v', "<", "<gv")

vim.keymap.set('n', "<leader>y", "\"+y")
vim.keymap.set('v', "<leader>y", "\"+y")
vim.keymap.set('n', "<leader>Y", "\"+Y")
vim.keymap.set('v', "<leader>p", "\"_dP")

-- Better window navigation
vim.keymap.set('n', "<C-h>", "<C-w>h")
vim.keymap.set('n', "<C-j>", "<C-w>j")
vim.keymap.set('n', "<C-k>", "<C-w>k")
vim.keymap.set('n', "<C-l>", "<C-w>l")

-- Better buffer navigation
vim.keymap.set('n', "<S-l>", ":bnext<CR>")
vim.keymap.set('n', "<S-h>", ":bprevious<CR>")
