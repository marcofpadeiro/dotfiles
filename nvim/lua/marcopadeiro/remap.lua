local nnoremap = require("marcopadeiro.keymap").nnoremap
local vnoremap = require("marcopadeiro.keymap").vnoremap
local inoremap = require("marcopadeiro.keymap").inoremap
local xnoremap = require("marcopadeiro.keymap").xnoremap
-- Telescope
nnoremap("<leader><leader>", "<cmd>Telescope find_files<CR>")
nnoremap("<leader>f", "<cmd>Telescope live_grep<CR>")

nnoremap("gd", ":lua vim.lsp.buf.definition()<CR>")
nnoremap("gr", ":lua vim.lsp.buf.references()<CR>")
nnoremap("K", ":lua vim.lsp.buf.hover()<CR>")
nnoremap("<leader>rn", ":lua vim.lsp.buf.rename()<CR>")
inoremap('<C-j>', '<cmd>lua require("cmp").select_next_item()<CR>')
inoremap('<C-k>', '<cmd>lua require("cmp").select_prev_item()<CR>')
inoremap('<C-a>', '<cmd>lua require("cmp").complete()<CR>')

-- Fast saving
nnoremap("<leader>w", "<cmd>:lua vim.lsp.buf.format()<CR>:w<CR>")

-- Harpoon
nnoremap("<leader>h", ':lua require("harpoon.ui").nav_file(1)<CR>')
nnoremap("<leader>j", ':lua require("harpoon.ui").nav_file(2)<CR>')
nnoremap("<leader>k", ':lua require("harpoon.ui").nav_file(3)<CR>')
nnoremap("<leader>l", ':lua require("harpoon.ui").nav_file(4)<CR>')
nnoremap("<leader>m", ':lua require("harpoon.ui").toggle_quick_menu()<CR>')
nnoremap("<leader>a", ':lua require("harpoon.mark").add_file()<CR>')

vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")

nnoremap("<leader>y", "\"+y")
vnoremap("<leader>y", "\"+y")
nnoremap("<leader>Y", "\"+Y")
xnoremap("<leader>p", "\"_dP")

-- Better window navigation
nnoremap("<C-h>", "<C-w>h")
nnoremap("<C-j>", "<C-w>j")
nnoremap("<C-k>", "<C-w>k")
nnoremap("<C-l>", "<C-w>l")

-- Better buffer navigation
nnoremap("<S-l>", ":bnext<CR>")
nnoremap("<S-h>", ":bprevious<CR>")

-- Nvimtree
nnoremap("<leader>e", ":NvimTreeToggle<cr>")
