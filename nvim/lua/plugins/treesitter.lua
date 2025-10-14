local ts = require('nvim-treesitter.configs')

ts.setup({
  ensure_installed = {
    "lua",
    "json",
    "rust",
    "go",
    "gitignore",
    "yaml",
    "java",
    "bash",
    "markdown",
    "markdown_inline",
    "toml",
  },
  sync_install = false,
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
  autotag = { enable = true }
})

local parsers = require('nvim-treesitter.parsers')
function _G.ensure_treesitter_language_installed()
  local lang = parsers.get_buf_lang()
  if parsers.get_parser_configs()[lang] and not parsers.has_parser(lang) then
    vim.schedule_wrap(function()
      vim.cmd("TSInstallSync " .. lang)
      vim.cmd [[e!]]
    end)()
  end
end

vim.cmd [[autocmd FileType * :lua ensure_treesitter_language_installed()]]
