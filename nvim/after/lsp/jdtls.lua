local mason_root = vim.fn.expand("$MASON")
if mason_root == "$MASON" or mason_root == "" then
  mason_root = vim.fn.expand("~/.local/share/nvim/mason")
end

local jdtls_root   = mason_root .. "/packages/jdtls"
local jdtls_config = jdtls_root .. "/config_linux"
local lombok       = jdtls_root .. "/lombok.jar"
local launcher     = vim.fn.glob(jdtls_root .. "/plugins/org.eclipse.equinox.launcher_*.jar")

return {
  cmd = {
    "java",
    (vim.fn.filereadable(lombok) == 1) and ("-javaagent:" .. lombok) or nil,
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "-Xmx4g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    "-jar", launcher,
    "-configuration", jdtls_config,
    "-data", vim.fn.stdpath('cache') .. '/jdtls' .. '/workspace',
  },

  settings = {
    java = {
      completion = {
        favoriteStaticMembers = {
          "org.junit.Assert.*",
          "org.mockito.Mockito.*",
          "org.mockito.ArgumentMatchers.*",
          "org.mockito.Answers.*",
        },
        importOrder = { "java", "javax", "com", "org" },
        guessMethodArguments = true,
      },
      format = { enabled = true },
      references = { includeDecompiledSources = true },
      signatureHelp = { enabled = true },
      sources = { organizeImports = { starThreshold = 999, staticStarThreshold = 999 } },
    },
  },
}
