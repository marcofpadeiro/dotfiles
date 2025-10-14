local plugin_dir = vim.fn.stdpath("config") .. "/lua/plugins"

for _, file in ipairs(vim.fn.readdir(plugin_dir, [[v:val =~ '\.lua$']])) do
  local mod = file:gsub("%.lua$", "")
<<<<<<< HEAD
  if mod ~= "init" then
=======
  if mod ~= "init" then -- avoid requiring itself
>>>>>>> 42abb035
    require("plugins." .. mod)
  end
end
