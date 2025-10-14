local ok_d, dap = pcall(require, 'dap')
if not ok_d then error(dap) end
local ok_ui, dap_ui = pcall(require, 'dapui')
if not ok_ui then return end
local ok_vt, dap_virtual_text = pcall(require, 'nvim-dap-virtual-text')
if not ok_vt then return end

dap_ui.setup()
dap_virtual_text.setup()

vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

vim.keymap.set("n", "<space>?", function()
  require("dapui").eval(nil, { enter = true })
end)

vim.keymap.set("n", "<F1>", dap.continue)
vim.keymap.set("n", "<F2>", dap.step_into)
vim.keymap.set("n", "<F3>", dap.step_over)
vim.keymap.set("n", "<F4>", dap.step_out)
vim.keymap.set("n", "<F5>", dap.step_back)
vim.keymap.set("n", "<F13>", dap.restart)

dap.listeners.before.attach.dapui_config = function()
  dap_ui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dap_ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dap_ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dap_ui.close()
end

local function apply_spec(spec)
  if type(spec) ~= "table" then return end

  if spec.adapters then
    for name, adapter in pairs(spec.adapters) do
      dap.adapters[name] = adapter
    end
  end

  if spec.configurations then
    for ft, confs in pairs(spec.configurations) do
      dap.configurations[ft] = dap.configurations[ft] or {}
      for _, cfg in ipairs(confs) do
        table.insert(dap.configurations[ft], cfg)
      end
    end
  end
end

local function load_dir(dir, prefix)
  for _, f in ipairs(vim.fn.readdir(dir)) do
    local full = dir .. "/" .. f
    if vim.fn.isdirectory(full) == 1 then
      load_dir(full, prefix .. f .. ".")
    elseif f:match("%.lua$") then
      local modname = prefix .. f:gsub("%.lua$", "")
      local ok, mod = pcall(require, modname)
      if ok then
        local spec = (type(mod) == "function") and mod or mod
        apply_spec(spec)
      else
        vim.notify(("dap: failed to load %s\n%s"):format(modname, mod), vim.log.levels.WARN)
      end
    end
  end
end

local dap_dir = vim.fn.stdpath("config") .. "/lua/daps/languages/"
local dap_prefix = "daps.languages."
load_dir(dap_dir, dap_prefix)
