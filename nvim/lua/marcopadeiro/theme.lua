local status_ok, theme = pcall(require, "onedark")
if not status_ok then
    return
end

theme.setup({
    style = "darker" 
})

theme.load()

vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
vim.cmd("myspecialcolors hi Normal ctermbg=red guibg=red")
