return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>a", function() require("harpoon"):list():add() end, desc = "Harpoon add" },
      { "<leader>m", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Harpoon menu" },
      { "<leader>n", function() require("harpoon"):list():select(1) end, desc = "Harpoon 1" },
      { "<leader>e", function() require("harpoon"):list():select(2) end, desc = "Harpoon 2" },
      { "<leader>i", function() require("harpoon"):list():select(3) end, desc = "Harpoon 3" },
      { "<leader>o", function() require("harpoon"):list():select(4) end, desc = "Harpoon 4" },
    },
    config = function()
      require("harpoon"):setup()
    end,
  },
}
