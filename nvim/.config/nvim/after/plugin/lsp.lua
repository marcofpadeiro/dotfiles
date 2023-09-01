local status_ok, lsp = pcall(require, "lsp-zero")
if not status_ok then
    return
end

lsp.preset("recommended")

lsp.ensure_installed({
    'lua_ls',
    'tsserver',
    'clangd',
    'rust_analyzer',
})

lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
end)

local lspconfig = require('lspconfig')

-- lua
lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

-- c
lspconfig.clangd.setup {}

-- rust
lsp.configure('rust_analyzer', {
    cmd = { 'rustup', 'run', 'stable', 'rust-analyzer' },
})


lsp.setup()

require('cmp')
