local function load()
    vim.cmd('packadd markdown-preview.nvim')
end

vim.api.nvim_create_user_command('MarkdownPreview', function()
    load()
    vim.cmd('MarkdownPreview')
end, {})

vim.api.nvim_create_user_command('MarkdownPreviewStop', function()
    load()
    vim.cmd('MarkdownPreviewStop')
end, {})

vim.api.nvim_create_user_command('MarkdownPreviewToggle', function()
    load()
    vim.cmd('MarkdownPreviewToggle')
end, {})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'markdown',
    callback = function()
        load()
    end,
})
