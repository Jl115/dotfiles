-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.scrolloff = 15
vim.g.lazyvim_picker = "telescope"

vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
vim.g.custom_cursor_mode = true -- Toggle this setting

vim.opt.termguicolors = true
vim.o.textwidth = 120

if vim.g.custom_cursor_mode then
  vim.opt.guicursor = "n-v-c:block-blinkon500,i-ci-ve:ver25-blinkon200,r-cr-o:hor20-blinkon200"
else
  vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr-o:hor20"
end
