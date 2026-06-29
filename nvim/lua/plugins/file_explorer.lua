return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "-", "<cmd>Oil<CR>", desc = "Oil: open parent directory" },
    },
    cmd = "Oil",
    opts = {
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
    },
  },
}
