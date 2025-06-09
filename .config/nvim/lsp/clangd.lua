return {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed",
  },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
  single_file_support = false,
  log_level = vim.lsp.protocol.MessageType.Warning,
  capabilities = {
    offsetEncoding = { "utf-16" },
  },
  init_options = {
    inlayHints = {
      enable = true,
      parameterNames = true,
      parameterTypes = true,
      variableTypes = true,
      functionReturnTypes = true,
    },
  },
}
