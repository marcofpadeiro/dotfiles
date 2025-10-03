-- config and enable all servers in /lua/lsp/servers
local function load_dir(dir, prefix)
    for _, f in ipairs(vim.fn.readdir(dir)) do
        local full = dir .. "/" .. f
        if vim.fn.isdirectory(full) == 1 then
            load_dir(full, prefix .. f .. ".")
        elseif f:match("%.lua$") then
            local mod = prefix .. f:gsub("%.lua$", "")
            local name = vim.fn.fnamemodify(f, ":t:r")
            vim.lsp.config[name] = require(mod)
            vim.lsp.enable(name)
        end
    end
end

local lsp_dir = vim.fn.stdpath("config") .. "/lua/lsp/servers/"
local lsp_prefix = "lsp.servers."

load_dir(lsp_dir, lsp_prefix)

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
    callback = function(event)
        local keymap = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        keymap("K", vim.lsp.buf.hover, "Hover Documentation")
        keymap("gd", vim.lsp.buf.definition, "Goto definition")
        keymap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
        keymap("<leader>rn", vim.lsp.buf.rename, "Rename all references")
        keymap("<leader>t", vim.diagnostic.open_float, "Open Diagnostic Float")
        keymap("form", vim.lsp.buf.format, "Format")
    end,
})
