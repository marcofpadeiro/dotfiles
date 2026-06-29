return {
  -- Surround
  { "kylechui/nvim-surround", event = "VeryLazy", config = true },

  -- Git signs
  { "lewis6991/gitsigns.nvim", event = "VeryLazy", config = true },

  -- Colorizer (highlight hex colors)
  {
    "NvChad/nvim-colorizer.lua",
    event = "VeryLazy",
    opts = {
      user_default_options = {
        mode = "virtualtext",
      },
    },
  },

  -- Colorscheme
  { "rebelot/kanagawa.nvim", priority = 1000 },
}
