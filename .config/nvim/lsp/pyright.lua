return {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "requirements.txt", "setup.py", "setup.cfg", ".git" },
  single_file_support = false,
  log_level = vim.lsp.protocol.MessageType.Warning,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "strict", -- or "strict"
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace", -- "openFilesOnly" → only current file, "workspace" → all files
      },
    },
  },
}
