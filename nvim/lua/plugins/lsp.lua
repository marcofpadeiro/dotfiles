-- cmp
local blink_cmp = require("blink.cmp")
blink_cmp.setup({
  cmdline = { enabled = false },
  keymap = {
    preset = "default",
    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<CR>'] = { 'select_and_accept', 'fallback' },
    ['<C-a>'] = { 'select_and_accept', 'fallback' },
    ['<C-k>'] = { 'select_prev', 'fallback' },
    ['<C-j>'] = { 'select_next', 'fallback' },
    ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
    ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
    ['<C-f>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
    ['<Tab>'] = nil,
    ['<S-Tab>'] = nil,
  },
  fuzzy = { implementation = "prefer_rust_with_warning" },
  sources = { default = { "lsp", "path", "snippets", "buffer" } },
  signature = { enabled = true },
  appearance = { nerd_font_variant = "normal" },
})

-- mason
local mason = require("mason")
mason.setup()

local mlspconfig = require("mason-lspconfig")
mlspconfig.setup({
  ensure_installed = {
    "lua_ls",
    "pyright",
    "ts_ls",
    "clangd",
    "gopls",
    "jsonls",
    "marksman",
    "rust_analyzer",
    "taplo",
    "yamlls",
    "bashls"
  },
  automatic_installation = true,
})

-- enable servers
for _, server_name in ipairs(mlspconfig.get_installed_servers()) do
  vim.lsp.enable(server_name)
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local keymap = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    keymap("K", vim.lsp.buf.hover, "Hover Documentation")
    keymap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
    keymap("<leader>rn", vim.lsp.buf.rename, "Rename all references")
    keymap("<leader>t", vim.diagnostic.open_float, "Open Diagnostic Float")
    keymap("gd", vim.lsp.buf.definition, "Goto Definition")
    keymap("<leader>fu", vim.lsp.buf.references, "Find Usages")
    keymap("form", vim.lsp.buf.format, "Format")
  end,
})

-- lazyload latex
vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    vim.cmd.packadd("vimtex")
  end,
})
