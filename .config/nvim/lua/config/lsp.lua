local lsp_dir = vim.fn.stdpath("config") .. "/lua/config/lsp"
local enabled_servers = {}

for _, file in ipairs(vim.fn.readdir(lsp_dir)) do
  local name = file:match("^(.*)%.lua$")
  if name then
    require("config.lsp." .. name)
    table.insert(enabled_servers, name)
  end
end

vim.lsp.enable(enabled_servers)

vim.diagnostic.config({
  virtual_text = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
      [vim.diagnostic.severity.WARN] = "WarningMsg",
    },
  },
})
