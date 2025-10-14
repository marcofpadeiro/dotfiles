local plugin_dir = vim.fn.stdpath("config") .. "/lua/plugins"

for _, file in ipairs(vim.fn.readdir(plugin_dir, [[v:val =~ '\.lua$']])) do
  local mod = file:gsub("%.lua$", "")
  if mod ~= "init" then
    require("plugins." .. mod)
  end
end
