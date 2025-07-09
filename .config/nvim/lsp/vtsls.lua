return {
  name = "vtsls", -- only if file is named tsserver.lua
  cmd = { "vtsls", "--stdio" },
  filetypes = {
    "vue",
    "javascript",
    "typescript",
    "javascriptreact",
    "typescriptreact",
  },
  root_markers = {
    "vite.config.ts",
    "next.config.js",
    "jsconfig.json",
    "tsconfig.json",
    "package.json",
    ".git",
  },
  single_file_support = false,
  log_level = vim.lsp.protocol.MessageType.Warning,
  telemetry = {
    telemetryLevel = "off",
  },
  settings = {
    typescript = {
      inlayHints = {
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
    javascript = {
      inlayHints = {
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
  },
}
