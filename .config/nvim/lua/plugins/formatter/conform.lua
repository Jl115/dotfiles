return {
  "stevearc/conform.nvim",

  opts = {
    formatters_by_ft = {
      javascript = { "prettierd" },
      typescript = { "prettierd" },
      json = { "prettierd" },
      markdown = { "prettierd" },
      css = { "prettierd" },
      html = { "prettierd" },
      vue = { "prettierd" },
      c = { "clang_format" },
      cpp = { "clang_format" },
      python = { "ruff", "ruff_organize_imports", "ruff_format" },
    },
    linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      vue = { "eslint_d" },
    },
  },
}
