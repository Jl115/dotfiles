return {
  cmd = { "docker-langserver", "--stdio" },
  filetypes = { "dockerfile" },
  root_markers = { "Dockerfile", ".git" },
  single_file_support = false,
  log_level = vim.lsp.protocol.MessageType.Warning,
}
