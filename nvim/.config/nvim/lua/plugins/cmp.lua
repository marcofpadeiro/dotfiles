local ok, blink_cmp = pcall(require, 'blink.cmp')
if not ok then return end

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
    fuzzy = {
        implementation = "prefer_rust_with_warning",
    },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },
    signature = {
        enabled = true,
    },
    completion = {
        documentation = {
            auto_show = true,
        },
    },
    appearance = {
        nerd_font_variant = "normal",
    },
})
