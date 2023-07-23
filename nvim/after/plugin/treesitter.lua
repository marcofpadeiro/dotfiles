local status_ok, nvimtreesitter = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

nvimtreesitter.setup {
  ensure_installed = { "c", "lua", "vim", "rust", "html", "css", "php", "javascript", "vimdoc", "query", "bash", "c_sharp", "cpp", "dockerfile", "go", "java", "json", "markdown", "python", "typescript" },
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  sync_install = true,
  auto_install = true,
  ignore_install = { },

  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = true,
  },
  indent = {
    enable = true,
  },
}
