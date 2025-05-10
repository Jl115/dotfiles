vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.flutter_tools_decorations = {}
-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
-- Set up transparency for UI elements
vim.cmd([[
  " General UI transparency
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NormalNC guibg=NONE ctermbg=NONE
  highlight NormalFloat guibg=NONE ctermbg=NONE
  highlight EndOfBuffer guibg=NONE ctermbg=NONE

  " NeoTree transparency
  highlight NeoTreeNormal guibg=NONE ctermbg=NONE
  highlight NeoTreeNormalNC guibg=NONE ctermbg=NONE
  highlight NeoTreeEndOfBuffer guibg=NONE ctermbg=NONE
  highlight NeoTreeWinSeparator guibg=NONE ctermbg=NONE
  highlight NeoTreeTitleBar guibg=NONE ctermbg=NONE
  highlight NeoTreeTabActive guibg=NONE ctermbg=NONE
  highlight NeoTreeTabInactive guibg=NONE ctermbg=NONE
  highlight NeoTreeTabSeparatorActive guibg=NONE ctermbg=NONE
  highlight NeoTreeTabSeparatorInactive guibg=NONE ctermbg=NONE

  " Telescope transparency
  highlight TelescopeNormal guibg=NONE ctermbg=NONE
  highlight TelescopeBorder guibg=NONE ctermbg=NONE
  highlight TelescopePromptNormal guibg=NONE ctermbg=NONE
  highlight TelescopePromptBorder guibg=NONE ctermbg=NONE
  highlight TelescopeResultsNormal guibg=NONE ctermbg=NONE
  highlight TelescopeResultsBorder guibg=NONE ctermbg=NONE
  highlight TelescopePreviewNormal guibg=NONE ctermbg=NONE
  highlight TelescopePreviewBorder guibg=NONE ctermbg=NONE

  " Lualine & StatusLine transparency
  highlight StatusLine guibg=NONE ctermbg=NONE
  highlight StatusLineNC guibg=NONE ctermbg=NONE
  highlight WinSeparator guibg=NONE ctermbg=NONE
  highlight VertSplit guibg=NONE ctermbg=NONE

  " Popup menu transparency
  highlight Pmenu guibg=NONE ctermbg=NONE
  highlight PmenuSel guibg=NONE ctermbg=NONE
  highlight InlayHint guibg=NONE ctermbg=NONE
  highlight CursorLine guibg=NONE ctermbg=NONE

  " Additional UI elements transparency
  highlight SignColumn guibg=NONE ctermbg=NONE
  highlight LineNr guibg=NONE ctermbg=NONE
  highlight CursorLineNr guibg=NONE ctermbg=NONE
  highlight FoldColumn guibg=NONE ctermbg=NONE
  highlight Folded guibg=NONE ctermbg=NONE
  
  " Floating windows transparency
  highlight FloatBorder guibg=NONE ctermbg=NONE
  highlight FloatShadow guibg=NONE ctermbg=NONE
  highlight FloatShadowThrough guibg=NONE ctermbg=NONE
  
  " Search and selection transparency

  " Message area transparency
  highlight MsgArea guibg=NONE ctermbg=NONE
  highlight MoreMsg guibg=NONE ctermbg=NONE
  highlight ErrorMsg guibg=NONE ctermbg=NONE
  highlight WarningMsg guibg=NONE ctermbg=NONE
]])
