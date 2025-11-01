local function load()
  vim.cmd('packadd markdown-preview.nvim')
end

vim.api.nvim_create_autocmd('CmdUndefined', {
  pattern = { 'MarkdownPreview', 'MarkdownPreviewStop', 'MarkdownPreviewToggle' },
  callback = function(args)
    load()
    vim.cmd(args.match)
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown' },
  callback = load,
})

vim.g.mkdp_browser = 'firefox'

-- nvim --headless +"packadd markdown-preview.nvim" +"call mkdp#util#install()" +q
