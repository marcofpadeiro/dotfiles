local M = {}

function M.setup()
  local ok, jdtls = pcall(require, "jdtls")
  if not ok then
    vim.notify("nvim-jdtls not installed: " .. tostring(jdtls), vim.log.levels.ERROR)
    return
  end

  local project_name  = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
  local workspace_dir = vim.fn.stdpath("data") .. "/jdtls_workspaces/" .. project_name

  local mason_pkg     = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
  local sys           = vim.uv.os_uname().sysname
  local config        = mason_pkg .. (sys == "Darwin" and "/config_mac"
    or sys:match("Windows") and "/config_win"
    or "/config_linux")

  local launcher      = vim.fn.glob(mason_pkg .. "/plugins/org.eclipse.equinox.launcher_*.jar", 1)
  if launcher == "" then
    vim.notify("JDTLS launcher jar not found in " .. mason_pkg .. "/plugins", vim.log.levels.ERROR)
    return
  end

  local lombok_path = vim.fn.expand("~/.local/share/nvim/lombok.jar")
  local has_lombok = vim.fn.filereadable(lombok_path) == 1

  local java = (os.getenv("JAVA_HOME") and (os.getenv("JAVA_HOME") .. "/bin/java")) or "java"

  local cmd = {
    java,
    has_lombok and ("-javaagent:" .. lombok_path) or nil,
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    "-jar", launcher,
    "-configuration", config,
    "-data", workspace_dir,
  }

  local filtered = {}
  for _, v in ipairs(cmd) do if v ~= nil then table.insert(filtered, v) end end
  cmd = filtered

  local capabilities = vim.lsp.protocol.make_client_capabilities()

  local on_attach = function(_, bufnr)
    local function map(k, fn, d) vim.keymap.set("n", k, fn, { buffer = bufnr, desc = "JDTLS: " .. d }) end
    map("<leader>oi", jdtls.organize_imports, "Organize Imports")
    map("<leader>tc", jdtls.test_class, "Run Test Class")
    map("<leader>tm", jdtls.test_nearest_method, "Run Test Method")
    map("<leader>ev", jdtls.extract_variable, "Extract Variable")
    map("<leader>ec", jdtls.extract_constant, "Extract Constant")
    map("<leader>em", jdtls.extract_method, "Extract Method")
  end

  jdtls.start_or_attach({
    cmd = cmd,
    root_dir = require("jdtls.setup").find_root({ "pom.xml", "gradlew", "mvnw", ".git" }),
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      java = {
        configuration = { updateBuildConfiguration = "interactive" },
        maven = { downloadSources = true },
        implementationsCodeLens = { enabled = true },
        referencesCodeLens = { enabled = true },
        format = { enabled = true },
      },
    },
    init_options = { bundles = {} },
  })
end

return M
