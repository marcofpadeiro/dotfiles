local plugin_path = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

return {
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },

  init_options = {
    hostInfo = "neovim",
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = plugin_path,
        languages = { 'vue' },
        configNamespace = 'typescript',
      }
    },
  },
}
