return {
  "mason-org/mason.nvim",
  opts = {
    ensure_installed = {
      -- Linting/Formatting
      "stylua",
      "shellcheck",
      "shfmt",
      "flake8",
      "prettierd",
      "ruff",
      "clang-format",
      -- LSPs
      "lua-language-server",
      "vtsls", -- replaces typescript-language-server
      "typescript-language-server",
      "sonarlint-language-server",
      "vue-language-server",
      "shfmt",
      "bash-language-server",
      "eslint_d",
      "dockerfile-language-server",
      "docker-compose-language-service",
      "rust-analyzer",
      "pyright",
      "jdtls",
      "marksman",
      "clangd",
      "gopls",
      -- Debugging / DAP
      "codelldb",
      "js-debug-adapter",
      "java-debug-adapter",
      "java-test",
    },
  },
}
