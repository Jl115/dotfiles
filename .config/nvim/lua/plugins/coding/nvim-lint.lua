return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      vue = { "eslint_d" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        -- 1. Try to find the nearest package.json or eslint config
        local root = vim.fs.find({ "package.json", "eslint.config.mjs", ".eslintrc.js" }, {
          path = vim.api.nvim_buf_get_name(0),
          upward = true,
        })[1]

        -- 2. Get the directory of that file (if found), otherwise use standard cwd
        local lint_cwd = root and vim.fs.dirname(root) or vim.fn.getcwd()

        -- 3. Run lint with the specific CWD for this buffer
        lint.try_lint(nil, { cwd = lint_cwd })
      end,
    })
  end,
}
