---@type vim.lsp.Config
return {
  cmd = { "marksman" },
  filetypes = { "markdown" },
  root_dir = require("lspconfig.util").root_pattern(".marksman.toml", "README.md", ".git"),
  single_file_support = false,
  log_level = vim.lsp.protocol.MessageType.Warning,
  settings = {}, -- marksman does not expose extra settings
}
