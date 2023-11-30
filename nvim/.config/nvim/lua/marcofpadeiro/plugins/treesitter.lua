return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
        "windwp/nvim-ts-autotag",
    },
    config = function()
        require("nvim-treesitter.configs").setup({
            highlight = {
                enable = true,
            },
            indent = { enable = true },
            autotag = { enable = true },
            ensure_installed = {
                "json",
                "typescript",
                "tsx",
                "html",
                "css",
                "lua",
                "gitignore",
                "vim",
                "yaml",
                "toml",
                "regex",
                "bash",
                "markdown",
                "markdown_inline",
                "go",
            },
            auto_install = true,
        })
    end,
}
