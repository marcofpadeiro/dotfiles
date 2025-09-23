local lsp_dir = vim.fn.stdpath("config") .. "/lua/lsp/servers/"
local lsp_prefix = "lsp.servers."

-- config and enable all servers in /lua/lsp/servers
for _, f in ipairs(vim.fn.readdir(lsp_dir)) do
    local full = lsp_dir .. "/" .. f
    if vim.fn.isdirectory(full) == 1 then
        load_dir(full, lsp_prefix .. f .. ".")
    elseif f:match("%.lua$") then
        local mod = lsp_prefix .. f:gsub("%.lua$", "")
        local name = vim.fn.fnamemodify(f, ":t:r")
        vim.lsp.config[name] = require(mod)
        vim.lsp.enable(name)
    end
end

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
    callback = function(event)
        local keymap = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        keymap("K", vim.lsp.buf.hover, "Hover Documentation")
        keymap("<leader>gd", vim.lsp.buf.definition, "Goto Declaration")
        keymap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
        keymap("<leader>rn", vim.lsp.buf.rename, "Rename all references")
        keymap("<leader>t", vim.diagnostic.open_float, "Open Diagnostic Float")
        keymap("<leader>form", vim.lsp.buf.format, "Format")
    end,
})
