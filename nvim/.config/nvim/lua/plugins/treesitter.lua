local ok, ts = pcall(require, 'nvim-treesitter.configs')
if not ok then return end

ts.setup({
    ensure_installed = {},
    auto_install = true,
    sync_install = false,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },

    indent = { enable = true },

    autotag = { enable = true },

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<CR>",
            node_incremental = "<CR>",
            node_decremental = "<BS>",
            scope_incremental = "<TAB>",
        },
    },
})

-- AUTOTAG
local k, autotag = pcall(require, 'nvim-ts-autotag')
if not k then return end

autotag.setup({
    opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = false
    }
})
