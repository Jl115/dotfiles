return {
  cmd = { "marksman" },
  filetypes = { "markdown" },
  root_markers = { ".marksman.toml", "README.md", ".git" },
  single_file_support = false,
  log_level = vim.lsp.protocol.MessageType.Warning,
  settings = {}, -- marksman does not expose extra settings
}
