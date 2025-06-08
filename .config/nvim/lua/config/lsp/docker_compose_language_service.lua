---@type vim.lsp.Config
return {
  cmd = { "docker-compose-langserver", "--stdio" },
  filetypes = { "yaml.docker-compose" },
  root_dir = require("lspconfig.util").root_pattern("docker-compose.yml", ".git"),
  single_file_support = false,
  log_level = vim.lsp.protocol.MessageType.Warning,
}
