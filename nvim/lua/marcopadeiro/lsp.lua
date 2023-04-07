local lsp_status_ok, lsp = pcall(require, "lsp-zero")
if not lsp_status_ok then
    return
end

local cmp = require("marcopadeiro.cmp")

lsp.preset("recommended")

local cmp_mappings = lsp.defaults.cmp_mappings({
    -- map <CR> to confirm
    ['<C-a>'] = cmp.mapping.confirm({ select = true }),
    ['<Cr>'] = cmp.mapping.confirm({ select = true }),
    ['<C-e>'] = cmp.mapping.close(),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.setup()
