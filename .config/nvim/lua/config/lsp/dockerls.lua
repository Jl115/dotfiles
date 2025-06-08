---@type vim.lsp.Config
return {
  cmd = { "docker-langserver", "--stdio" },
  filetypes = { "dockerfile" },
  root_dir = require("lspconfig.util").root_pattern("Dockerfile", ".git"),
  single_file_support = false,
  log_level = vim.lsp.protocol.MessageType.Warning,
}
