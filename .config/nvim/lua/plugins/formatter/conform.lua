return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      javascript = { "prettierd" }, -- Prettier for formatting
      typescript = { "prettierd" },
      json = { "prettierd" },
      markdown = { "prettierd" },
      css = { "prettierd" },
      html = { "prettierd" },
      vue = { "prettierd" },
      c = { "clang_format" },
      cpp = { "clang_format" },

      -- Add other formats you want prettierd to handle
    },

    linters_by_ft = {
      javascript = { "eslint_d" }, -- ESLint for linting
      typescript = { "eslint_d" },
      json = { "eslint_d" },
      python = { "black", "isort" },

      markdown = { "eslint_d" },
      css = { "eslint_d" },
      html = { "eslint_d" },
      vue = { "eslint_d" },
      -- Add other linters for each language
    },

    -- If you're using `eslint-lsp`, you can configure it as an LSP-based linter
    -- Example with `eslint-lsp`:
    lsp_linters = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      json = { "eslint_d" },
      markdown = { "eslint_d" },
      css = { "eslint_d" },
      html = { "eslint_d" },
      vue = { "eslint_d" },
      -- You can also add additional languages as necessary
    },
  },
}
