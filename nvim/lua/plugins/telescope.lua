local ok_t, telescope = pcall(require, 'telescope')
if not ok_t then return end
local ok_b, builtin = pcall(require, 'telescope.builtin')
if not ok_b then return end
local ok, neoclip = pcall(require, 'neoclip')
if not ok then return end

vim.keymap.set('n', '<leader>ff', builtin.find_files, { silent = true })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { silent = true })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { silent = true })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { silent = true })
vim.keymap.set('n', '<leader>fy', '<cmd>Telescope neoclip<CR>', { silent = true })

local ok_a, actions = pcall(require, 'telescope.actions')
if not ok_a then actions = {} end

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
      },
    },
    file_ignore_patterns = { "node_modules/.*", "pack/.*", "%.git/.*" }
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
  },
})

neoclip.setup()

pcall(telescope.load_extension, 'fzf')
pcall(telescope.load_extension, 'neoclip')
