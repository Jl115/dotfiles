return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  enabled = true,
  lazy = false,
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    snippets = {
      expand = function(snippet, _)
        return LazyVim.cmp.expand(snippet)
      end,
    },
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = "mono",
    },
    completion = {
      accept = {
        auto_brackets = { enabled = true },
      },
      menu = {
        draw = {
          treesitter = { "lsp" },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      ghost_text = {
        enabled = vim.g.ai_cmp,
      },
    },
    sources = {
      default = {
        "snippets",
        "lsp",
        "path",
        "buffer",
      },
    },

    cmdline = {
      enabled = false,
      sources = {
        "cmdline",
        "path",
      },
    },
    keymap = {
      preset = "enter", -- keep original keybindings (no <Tab>/<CR>)
      ["<C-y>"] = { "select_and_accept" },
    },
  },
}
