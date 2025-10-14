-- Mason
require("mason").setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
local function on_attach(_, bufnr)
  local function keymap(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
  end
  keymap("K", vim.lsp.buf.hover, "Hover")
  keymap("gd", vim.lsp.buf.definition, "Goto definition")
  keymap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
  keymap("<leader>rn", vim.lsp.buf.rename, "Rename")
  keymap("<leader>t", vim.diagnostic.open_float, "Diagnostics float")
  keymap("form", function() vim.lsp.buf.format({ async = true }) end, "Format")
end

require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "pyright",
    "ts_ls",
    "bashls",
    "clangd",
    "cssls",
    "gopls",
    "html",
    "jsonls",
    "lemminx",
    "marksman",
    "phpactor",
    "rust_analyzer",
    "sqlls",
    "taplo",
    "texlab",
    "vue_ls",
    "yamlls",
  },
  automatic_installation = true,
})

local lsp_prefix = "lsp.servers."
local lsp_dir    = vim.fn.stdpath("config") .. "/lua/lsp/servers"

local function load_dir(dir, prefix, out)
  out = out or {}
  if vim.fn.isdirectory(dir) ~= 1 then return out end
  for _, f in ipairs(vim.fn.readdir(dir)) do
    local full = dir .. "/" .. f
    if vim.fn.isdirectory(full) == 1 then
      load_dir(full, prefix .. f .. ".", out)
    elseif f:sub(-4) == ".lua" then
      local mod      = prefix .. f:sub(1, -5)
      local name     = f:sub(1, -5)
      local ok, conf = pcall(require, mod)
      if ok then
        if type(conf) == "function" then
          local ok2, maybe = pcall(conf, { on_attach = on_attach, capabilities = capabilities })
          if ok2 and type(maybe) == "table" then out[name] = maybe end
        elseif type(conf) == "table" then
          out[name] = conf
        end
      else
        vim.schedule(function()
          vim.notify("Failed loading " .. mod .. ": " .. tostring(conf), vim.log.levels.WARN)
        end)
      end
    end
  end
  return out
end

local server_opts = load_dir(lsp_dir, lsp_prefix)

local function setup(server_id)
  if server_id == "jdtls" then return end
  local filename_key        = server_id
  local file_opts           = server_opts[filename_key] or {}

  local opts                = vim.tbl_deep_extend("force", {
    on_attach    = on_attach,
    capabilities = capabilities,
  }, file_opts)

  vim.lsp.config[server_id] = opts
  vim.lsp.enable(server_id)
end

local lspconfig = require("mason-lspconfig")
if lspconfig.setup_handlers then
  lspconfig.setup_handlers({
    function(server_id) setup(server_id) end
  })
else
  for _, server_id in ipairs(lspconfig.get_installed_servers()) do
    setup(server_id)
  end
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    require("lsp.servers.jdtls")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    vim.cmd.packadd("vimtex")
  end,
})
