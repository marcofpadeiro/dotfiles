return {
    cmd = { "bash-language-server", "start" },
    filetypes = { "sh" },
    single_file_support = true,
    settings = {
        bashIde = {
            globPattern = vim.env.GLOB_PATTERN or "**/*@(.sh|.inc|.bash|.command)",
        },
    },
}
