return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = {
      { "<leader>tt", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<leader>tg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
      { "<leader><leader>", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
      { "<leader>th", "<cmd>Telescope help_tags<CR>", desc = "Help tags" },
      { "<leader>ty", "<cmd>Telescope neoclip<CR>", desc = "Neoclip" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "AckslD/nvim-neoclip.lua",
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
          },
          file_ignore_patterns = { "node_modules/.*", "pack/.*", "%.git/.*" },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })

      require("neoclip").setup()
      pcall(telescope.load_extension, "fzf")
      pcall(telescope.load_extension, "neoclip")
    end,
  },
}
