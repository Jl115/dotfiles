return {

  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "stevearc/dressing.nvim",
    },
    cmd = { "CodeCompanion", "CodeCompanionChat" },
    opts = {
      auto_start = true,
      strategies = {
        chat = {
          adapter = {
            name = "copilot",
            model = "claude-3.7-sonnet",
          },
        },
        inline = {
          adapter = {
            name = "copilot",
            model = "claude-3.7-sonnet",
          },
        },
      },
    },
    config = function(_, opts)
      require("codecompanion").setup(opts)
      vim.keymap.set("i", "*", function()
        return require("codecompanion.inline").accept()
      end, { desc = "Accept inline hint", expr = true, silent = true })
    end,
    lazy = true,
  },
}
