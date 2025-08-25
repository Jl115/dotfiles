return {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000, version = "v1.10.0" },
  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
