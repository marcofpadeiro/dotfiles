return {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue" },
    root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },

    init_options = {
        hostInfo = "neovim",
        plugins = {
            {
                name = '@vue/typescript-plugin',
                location = '/usr/sbin/vue-language-server',
                languages = { 'vue' },
                configNamespace = 'typescript',
            }
        },
    },
}
