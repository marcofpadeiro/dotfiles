---@brief

---@type vim.lsp.Config
local M = {}

local jdtls_root = vim.fn.expand("/usr/share/java/jdtls")
local jdtls_config = jdtls_root .. "/config_linux"

local lombok = jdtls_root .. "/lombok.jar"
local lombok_agent = vim.fn.filereadable(lombok) == 1 and ("-javaagent:" .. lombok) or nil

local launcher = vim.fn.glob(jdtls_root .. "/plugins/org.eclipse.equinox.launcher_*.jar")

local function workspace_dir()
    local name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    return vim.fn.expand("~/.local/share/jdtls-workspaces/") .. name
end

local cmd = {
    "java",
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
}

if lombok_agent then
    table.insert(cmd, 1, lombok_agent)
end

table.insert(cmd, "-jar")
table.insert(cmd, launcher)
table.insert(cmd, "-configuration")
table.insert(cmd, jdtls_config)
table.insert(cmd, "-data")
table.insert(cmd, workspace_dir())

M.cmd = cmd
M.filetypes = { "java" }
M.root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }

M.settings = {
    java = {
        signatureHelp = { enabled = true },
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
        sources = { organizeImports = { starThreshold = 999, staticStarThreshold = 999 } },
        format = {
            enabled = true,
        },
        references = { includeDecompiledSources = true },
    },
}

M.init_options = { bundles = {} }

return M
