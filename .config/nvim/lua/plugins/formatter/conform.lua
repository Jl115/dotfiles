return {
  "stevearc/conform.nvim",
  opts = {
    -- 1. Keep the order: Fix imports (eslint_d) -> Format style (prettierd)
    formatters_by_ft = {
      javascript = { "eslint_d", "prettierd" },
      typescript = { "eslint_d", "prettierd" },
      javascriptreact = { "eslint_d", "prettierd" },
      typescriptreact = { "eslint_d", "prettierd" },
      vue = { "eslint_d", "prettierd" },

      -- ... keep your other languages ...
      json = { "prettierd" },
      markdown = { "prettierd" },
      java = { "google-java-format" },
      dart = { "dart_format" },
      css = { "prettierd" },
      html = { "prettierd" },
      c = { "clang_format" },
      cpp = { "clang_format" },
      python = { "ruff_fix", "ruff_format" },
      shell = { "shfmt" },
      bash = { "shfmt" },
    },

    formatters = {
      eslint_d = {
        require_cwd = true,
      },

      dart_format = {
        command = "fvm",
        args = { "dart", "format", "$FILENAME" },
        stdin = false,
      },
    },
  },
}
