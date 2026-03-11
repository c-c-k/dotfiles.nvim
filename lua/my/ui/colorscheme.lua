local my = require "my"
---@class my.ui.colorscheme
local M = {}

M.opts = {}
M.opts.solarized_osaka_general = function(_, opts) ---@cast opts MyNoOptsSpec
  return my.tbl.merge_dicts_into_last(opts, {
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
    dim_inactive = false,
    on_highlights = function(highlights, colors)
      -- Avoid dimming text in inactive windows, `dim_inactive` only affects the background
      highlights.NormalNC = { fg = colors.base0 } -- normal text in non-current windows
      -- Make cursor line a bit more visible
      highlights.CursorLine = { bg = colors.base02, sp = colors.base1 } -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
    end,
  } --[[@as MyNoOptsSpec]])
end

return M
