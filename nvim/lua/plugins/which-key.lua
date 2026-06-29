return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix",
    spec = {
      { "<leader>t", group = "Telescope" },
      { "<leader>d", group = "Debug" },
      { "<leader>c", group = "Code" },
      { "<leader>l", group = "LSP" },
      { "<leader>f", group = "Find" },
    },
  },
  keys = {
    { "<leader>?", function() require("which-key").show({ global = true }) end, desc = "Keybind Manual" },
  },
}
