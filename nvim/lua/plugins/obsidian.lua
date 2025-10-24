local vault_path = vim.fn.expand("~/Documents/notes")

local cwd = vim.fn.getcwd()

if cwd:find(vault_path, 1, true) then
  local ok, obsidian = pcall(require, 'obsidian')
  if not ok then return end

  vim.opt.linebreak = true
  vim.opt.wrap = true
  vim.opt.breakindent = true
  vim.opt.conceallevel = 2
  vim.keymap.set("n", "<leader>n", "<cmd>ObsidianNew<CR>", { desc = "New Obsidian note" })
  vim.keymap.set("n", "<leader>d", "<cmd>ObsidianToday<CR>", { desc = "Today's daily note" })
  vim.keymap.set("n", "<leader>t", "<cmd>ObsidianNewFromTemplate<CR>", { desc = "New from template" })


  vim.keymap.set("n", "gd", function()
    vim.cmd("ObsidianFollowLink")
  end, { desc = "Follow Obsidian link" })

  obsidian.setup({
    workspaces = {
      {
        name = "personal",
        path = vault_path,
      },
    },

    notes_subdir = "01 - drafts",

    -- Optional, set the log level for obsidian.nvim. This is an integer corresponding to one of the log
    -- levels defined by "vim.log.levels.*".
    log_level = vim.log.levels.INFO,

    daily_notes = {
      folder = "05 - personal/dailies",
      date_format = "%Y/%B/%Y-%m-%d_%A",
      default_tags = { "daily-notes" },
      template = "daily.md"
    },

    note_id_func = function(title)
      if title and title ~= "" then
        return title
      else
        return tostring(os.time())
      end
    end,

    -- Optional, alternatively you can customize the frontmatter data.
    ---@return table
    note_frontmatter_func = function(note)
      -- Add the title of the note as an alias.
      if note.title then
        note:add_alias(note.title)
      end

      local out = { id = note.id, references = note.references, tags = note.tags }

      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end

      return out
    end,


    mappings = {
      ["gf"] = {
        action = function()
          return obsidian.util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      ["<leader>ch"] = {
        action = function()
          return obsidian.util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
      ["<cr>"] = {
        action = function()
          return obsidian.util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      }
    },
    new_notes_location = "notes_subdir",

    templates = {
      folder = "templates",
      substitutions = {},
    },
  })
end



-- WRAP text
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*.md",
  callback = function(args)
  end,
})
