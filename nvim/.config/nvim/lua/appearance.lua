local icons = {
    [vim.diagnostic.severity.ERROR] = " ",
    [vim.diagnostic.severity.WARN]  = " ",
    [vim.diagnostic.severity.INFO]  = " ",
    [vim.diagnostic.severity.HINT]  = "󰌵 ",
}

-- lsp signs
vim.diagnostic.config({
    -- inline messages
    virtual_text = {
        spacing = 2,
        prefix = function(diagnostic)
            return icons[diagnostic.severity] or "● "
        end,
    },
    signs = false
})

vim.o.background = "dark"
vim.cmd.colorscheme("gruvbox")
