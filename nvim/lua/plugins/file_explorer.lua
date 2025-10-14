local ok, oil = pcall(require, 'oil')
if not ok then return end

oil.setup({
  default_file_explorer = true,
  delete_to_trash = true,
  columns = { "icon" },
  view_options = {
    show_hidden = false,
  },
  float = {
    padding = 2,
    max_width = 110,
    max_height = 90,
    win_options = {
      winblend = 0,
    },
    get_win_title = nil,
    preview_split = "auto",
    override = function(conf)
      return conf
    end,
  },
})

-- Quick access mappings (assuming you set mapleader EARLY in init.lua)
vim.keymap.set('n', '-', '<cmd>Oil<CR>', { desc = 'Oil: open parent directory' })
vim.keymap.set('n', '<leader>e', function() oil.open_float() end, { desc = 'Oil: open CWD' })
