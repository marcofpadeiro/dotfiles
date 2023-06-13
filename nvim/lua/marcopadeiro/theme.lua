local status_ok, theme = pcall(require, "onedark")
if not status_ok then
    return
end

theme.setup({
    style = "darker",
    transparent = true,
})

theme.load()
vim.cmd [[hi Normal guibg=NONE ctermbg=NONE]]
vim.cmd [[hi NonText guibg=NONE ctermbg=NONE]]
vim.cmd [[hi NvimTreeNormal guibg=NONE ctermbg=NONE]]
