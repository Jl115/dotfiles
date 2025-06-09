return {
  cmd = { "docker-compose-langserver", "--stdio" },
  filetypes = { "yaml.docker-compose" },
  root_markers = { "docker-compose.yml", ".git" },
  single_file_support = false,
  log_level = vim.lsp.protocol.MessageType.Warning,
}
