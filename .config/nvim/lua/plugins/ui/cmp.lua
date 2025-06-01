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
    },
    keymap = {
      preset = "enter", -- disables all default mappings including <Tab> and <CR>
      ["<C-y>"] = { "select_and_accept" },
    },

    ui = {
      border = "rounded",
      max_height = 12,
      scrollbar = true,
      winhighlight = "Normal:BlinkCmpWindow,FloatBorder:FloatBorder",
    },
  },
  config = function(_, opts)
    vim.api.nvim_set_hl(0, "BlinkCmpWindow", { bg = "#2e0a22" })
    require("blink.cmp").setup(opts)
  end,
}
